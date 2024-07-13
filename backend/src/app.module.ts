import { Module } from '@nestjs/common';
import { UsersModule } from './modules/user/users.module';
import { Pet_S_Module } from './modules/pet_service/pet_services.module';
import { ConfigModule } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { PetModule } from './modules/pet/pet.module';
@Module({
  imports: [ConfigModule.forRoot({
    envFilePath: '.env',
    isGlobal: true
  }),
  MongooseModule.forRoot(process.env.DB_URI),
    UsersModule,
    Pet_S_Module,
    PetModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
