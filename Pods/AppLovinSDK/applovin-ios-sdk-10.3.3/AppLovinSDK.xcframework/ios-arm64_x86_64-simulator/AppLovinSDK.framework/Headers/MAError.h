//
//  MAError+Internal.h
//  AppLovinSDK
//
//  Created by Thomas So on 5/3/21.
//

#import <Foundation/Foundation.h>
#import "MAErrorCode.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * This class encapsulates various data for MAX load and display errors.
 */
@interface MAError : NSObject

/**
 * The error code for the error. Will be one of the codes listed under the @c MAErrorCode enum.
 */
@property (nonatomic, assign, readonly) MAErrorCode code;

/**
 * The error message for the error.
 */
@property (nonatomic, copy, readonly) NSString *message;

/**
 * A description string containing error codes and reasons for why each mediated network failed to load an ad.
 */
@property (nonatomic, copy, readonly, nullable) NSString *adLoadFailureInfo;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
