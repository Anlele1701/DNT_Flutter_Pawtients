import { Injectable } from '@nestjs/common';
import { GoogleGenerativeAI } from '@google/generative-ai';
import { UsersService } from '../user/users.service';
import { Model } from 'mongoose';
import { User } from 'src/schemas/User.schema';
import { MongoDBAtlasVectorSearch } from '@langchain/mongodb';
import { MongoClient } from 'mongodb';
import { InjectModel } from '@nestjs/mongoose';
import { CohereEmbeddings } from '@langchain/cohere';
import { RunnableSequence } from '@langchain/core/runnables';
import {
  ChatGoogleGenerativeAI,
  GoogleGenerativeAIEmbeddings,
} from '@langchain/google-genai';
@Injectable()
export class ChatbotService {
  private genAI;
  private model;
  private client: MongoClient;
  private namespace = 'langchain.test';
  private dbName: string;
  private collectionName: string;
  private collection: any;
  constructor(
    @InjectModel(User.name) private userModel: Model<User>,

    private readonly userSerivce: UsersService,
  ) {
    this.genAI = new GoogleGenerativeAI(process.env.GG_API_KEY);
    this.model = this.genAI.getGenerativeModel({ model: 'gemini-1.5-flash' });
    this.client = new MongoClient(process.env.DB_URI);
    [this.dbName, this.collectionName] = this.namespace.split('.');
    this.collection = this.client
      .db(this.dbName)
      .collection(this.collectionName);
  }
  async getPromptResponse(prompt: string) {
    await this.userSerivce.findByID('667c3f2b5e667b4546f51c48');
    const result = await this.model.generateContent(prompt);
    const response = await result.response;
    const text = response.text();
    return { message: text };
  }
  async testVector() {
    await this.client.connect();
    await MongoDBAtlasVectorSearch.fromTexts(
      ['Hello world', 'Bye bye', "What's this?"],
      [{ id: 2 }, { id: 1 }, { id: 3 }],
      new GoogleGenerativeAIEmbeddings({ apiKey: process.env.GG_API_KEY }),
      {
        collection: this.collection,
        indexName: 'vector_index', // The name of the Atlas search index. Defaults to "default"
        textKey: 'text', // The name of the collection field containing the raw content. Defaults to "text"
        embeddingKey: 'embedding', // The name of the collection field containing the embedded text. Defaults to "embedding"
      },
    );
    const vectorStore = new MongoDBAtlasVectorSearch(
      new GoogleGenerativeAIEmbeddings({ apiKey: process.env.GG_API_KEY }),
      {
        collection: this.collection,
        indexName: 'vector_index',
        textKey: 'text',
        embeddingKey: 'embedding',
      },
    );
    const model = new ChatGoogleGenerativeAI({
      apiKey: process.env.GG_API_KEY,
      model: 'gemini-1.5-flash',
      maxOutputTokens: 2048,
    });
    const retriever = vectorStore.asRetriever({ k: 2 });
  }
}
