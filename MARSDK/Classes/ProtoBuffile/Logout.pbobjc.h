// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: logout.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN

#pragma mark - LogoutRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface LogoutRoot : GPBRootObject
@end

#pragma mark - LogoutRequest

typedef GPB_ENUM(LogoutRequest_FieldNumber) {
  LogoutRequest_FieldNumber_Token = 1,
  LogoutRequest_FieldNumber_Uid = 2,
  LogoutRequest_FieldNumber_Domain = 3,
  LogoutRequest_FieldNumber_Timestamp = 4,
};

@interface LogoutRequest : GPBMessage

/** 用户token */
@property(nonatomic, readwrite, copy, null_resettable) NSString *token;

/** 用户id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *uid;

@property(nonatomic, readwrite) int32_t domain;

/** 发包时间戳 */
@property(nonatomic, readwrite) int64_t timestamp;

@end

#pragma mark - LogoutResponse

/**
 * logout的响应包没有包体
 **/
@interface LogoutResponse : GPBMessage

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)