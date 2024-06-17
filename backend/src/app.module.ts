import { Module } from '@nestjs/common';
import {MongooseModule} from '@nestjs/mongoose';
import { UsersModule } from './user/users.module';
import url from './configs/keys';
@Module({
  imports: [MongooseModule.forRoot(url),
    UsersModule
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
