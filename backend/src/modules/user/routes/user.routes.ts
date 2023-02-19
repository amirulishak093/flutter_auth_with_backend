import { FastifyPluginAsyncTypebox } from '@fastify/type-provider-typebox';
import { Type } from '@sinclair/typebox';
import bcrypt from 'bcryptjs';
import createHttpError from 'http-errors';

import { UserSchema } from '../schema/user.schema';

const userRoutes: FastifyPluginAsyncTypebox = async (server) => {
  // Create user
  server.post(
    '/',
    {
      schema: {
        body: Type.Omit(UserSchema, ['id', 'createdAt', 'updatedAt']),
        response: {
          201: Type.Object({ accessToken: Type.String() }),
        },
      },
    },
    async (req, reply) => {
      const passwordHash = await bcrypt.hash(req.body.password, 10);

      const user = await server.prisma.user.create({
        data: {
          username: req.body.username,
          password: passwordHash,
          bio: req.body.bio,
        },
      });

      const token = server.jwt.sign(
        { id: user.id },
        {
          expiresIn: server.config.JWT_EXPIRES_IN,
        },
      );

      reply.send({ accessToken: token });
    },
  );

  // Get user by id
  server.get(
    '/:id',
    {
      schema: {
        params: Type.Pick(UserSchema, ['id']),
        response: {
          200: Type.Omit(UserSchema, ['password', 'updatedAt']),
        },
      },
    },
    async (req, reply) => {
      await req.jwtVerify();

      const user = await server.prisma.user.findUnique({
        where: {
          id: req.params.id,
        },
      });

      if (!user) {
        throw createHttpError(404, 'User not found');
      }

      reply.send({
        id: user.id,
        username: user.username,
        bio: user.bio,
        createdAt: user.createdAt.toISOString(),
      });
    },
  );

  // Get curent user
  server.get(
    '/me',
    {
      schema: {
        response: {
          200: Type.Omit(UserSchema, ['password', 'updatedAt']),
        },
      },
    },
    async (req, reply) => {
      await req.jwtVerify();

      const user = await server.prisma.user.findUnique({
        where: {
          id: req.user.id,
        },
      });

      if (!user) {
        throw createHttpError(404, 'User not found');
      }

      reply.send({
        id: user.id,
        username: user.username,
        bio: user.bio,
        createdAt: user.createdAt.toISOString(),
      });
    },
  );

  // Login
  server.post(
    '/login',
    {
      schema: {
        body: Type.Pick(UserSchema, ['username', 'password']),
        response: {
          200: Type.Object({ accessToken: Type.String() }),
        },
      },
    },
    async (req, reply) => {
      const user = await server.prisma.user.findUnique({ where: { username: req.body.username } });

      if (!user) {
        throw createHttpError(404, 'Username not found');
      }

      const result = await bcrypt.compare(req.body.password, user.password);

      if (!result) {
        throw createHttpError(401, 'Password incorrect');
      }

      const token = server.jwt.sign(
        { id: user.id },
        {
          expiresIn: server.config.JWT_EXPIRES_IN,
        },
      );

      reply.send({ accessToken: token });
    },
  );
};

export default userRoutes;
