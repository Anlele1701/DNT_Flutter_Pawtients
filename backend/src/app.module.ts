import { Module } from '@nestjs/common';
import {MongooseModule} from '@nestjs/mongoose';
import { UsersModule } from './user/users.module';
import url from './configs/keys';
import { Pet_S_Module } from './modules/pet_service/pet_services.module';
@Module({
  imports: [MongooseModule.forRoot(url),
    UsersModule,
    Pet_S_Module
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
