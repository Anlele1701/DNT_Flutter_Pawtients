import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export class Image extends Document {
  filename: string;
  data: Buffer;
  mimetype: string;
}