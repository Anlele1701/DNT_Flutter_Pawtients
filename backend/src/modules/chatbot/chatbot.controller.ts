import { Get, Controller, Post } from '@nestjs/common';
import { ChatbotService } from './chatbot.service';
@Controller('chatbot')
export class ChatbotController {
  constructor(private readonly openAIService: ChatbotService) {}
  @Post('chatbotAnswer')
  async chatbotAnswer() {
    return this.openAIService.getPromptResponse(
      'Give me infomation about the user of this ID from database 667c3f2b5e667b4546f51c48',
    );
  }
  @Get('testVector')
  async testVector() {
    return this.openAIService.testVector();
  }
}
