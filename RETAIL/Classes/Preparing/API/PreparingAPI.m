
/******************************************************************************
 *  @file   : PreparingAPI.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-03
 *  @brief  : 准备给进入 App 时，获取数据的接口
 ******************************************************************************/

#import "PreparingAPI.h"

#import "OrgStorage.h"
//#import "FakeDatabase.h"

@interface PreparingAPI ()

@property (nonatomic,strong) OrgStorage *orgStorage;

@end

@implementation PreparingAPI

- (void)getEssentialData:(void (^)(int, int, NSString *))progress
              completion:(void (^)(BOOL, NSString *))completion
{
//  self.orgStorage.products = [FakeDatabase products];
//  self.orgStorage.contacts = [FakeDatabase contacts];
  
  completion(YES ,nil);
}

- (OrgStorage *)orgStorage
{
  return [OrgStorage getInstance];
}

@end
