USE [master]
GO

/****** Object:  Database [Chronicler]    Script Date: 04/12/2012 16:30:54 ******/
CREATE DATABASE [Chronicler] ON  PRIMARY 
( NAME = N'Chronicler', FILENAME = N'InsertFileNameHere' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Chronicler_log', FILENAME = N'InsertLogFileNameHere' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [Chronicler] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Chronicler].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Chronicler] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Chronicler] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Chronicler] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Chronicler] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Chronicler] SET ARITHABORT OFF 
GO

ALTER DATABASE [Chronicler] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Chronicler] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [Chronicler] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Chronicler] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Chronicler] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Chronicler] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Chronicler] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Chronicler] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Chronicler] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Chronicler] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Chronicler] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Chronicler] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Chronicler] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Chronicler] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Chronicler] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Chronicler] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Chronicler] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Chronicler] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Chronicler] SET  READ_WRITE 
GO

ALTER DATABASE [Chronicler] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [Chronicler] SET  MULTI_USER 
GO

ALTER DATABASE [Chronicler] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Chronicler] SET DB_CHAINING OFF 
GO

