﻿/*
DROP TABLE Events;
DROP TABLE Commands;
DROP TABLE Snapshots;
DROP TABLE Aggregates;
*/

CREATE TABLE [Aggregates]
(
    [Id] GUID NOT NULL,
    [TenantId] GUID NOT NULL,
    [Version] BIGINT NOT NULL CHECK ([Version] > 0),
    [Snapshot] BIGINT NOT NULL CHECK ([Snapshot] >= 0),
    [Created] DATETIME NOT NULL DEFAULT (datetime('now')),
    [RuntimeType] NVARCHAR(256) NOT NULL,
    CONSTRAINT [PK_Aggregates] PRIMARY KEY ([Id])
);

CREATE TABLE [Commands]
(
    [Id] GUID NOT NULL,
    [Payload] BLOB,
    CONSTRAINT [PK_Commands] PRIMARY KEY ([Id])
);

CREATE TABLE [Events]
(
    [Id] GUID NOT NULL,
    [Version] BIGINT NOT NULL CHECK ([Version] > 0),
    [CommitSequence] INTEGER PRIMARY KEY NOT NULL,
    [Created] DATETIME NOT NULL DEFAULT (datetime('now')),
    [CommandId] GUID,
    [Payload] BLOB NOT NULL
);

CREATE TABLE [Snapshots]
(
    [Id] GUID NOT NULL,
    [Version] BIGINT NOT NULL CHECK ([Version] > 0),
    [Created] DATETIME NOT NULL DEFAULT (datetime('now')),
    [Payload] BLOB NOT NULL,
    CONSTRAINT [PK_Snapshots] PRIMARY KEY ([Id], [Version])
);

CREATE UNIQUE INDEX [PK_Events] ON [Events] ([Id], [Version]);
CREATE INDEX [IX_Events_CommandId] ON [Events] ([CommandId]);