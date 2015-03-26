
/******************************************************************************
 *  @file   : OrgServiceCache.h
 *  @author : WANG JIE
 *  @date   : 2014-12-18
 *  @brief  : 架构接口数据缓存
 ******************************************************************************/

#import "SFACache.h"

#import "OrgEntities.h"

@interface OrgServiceCache : SFACache

+ (instancetype)getInstance;

@property (nonatomic) NSString * employeeId;

@property (nonatomic) Employee * user;
@property (nonatomic) NSArray  * subordinates;
@property (nonatomic) NSArray  * managers;

@property (nonatomic) NSArray * posts;
@property (nonatomic) NSArray * postEmployees;
@property (nonatomic) NSArray * departments;
@property (nonatomic) NSArray * products;
@property (nonatomic) NSArray * doctors;
@property (nonatomic) NSArray * hospitals;
@property (nonatomic) NSArray * hospDepartments;
@property (nonatomic) NSArray * hospDepartmentDoctors;
@property (nonatomic) NSArray * doctorProducts;
@property (nonatomic) NSArray * postSalesUnits;
@property (nonatomic) NSArray * sysCodes;
@property (nonatomic) NSArray * contectInfos;

@property (nonatomic) BOOL       needReset;
@property (nonatomic) long long  serverTime;

- (void)clear;

@end
