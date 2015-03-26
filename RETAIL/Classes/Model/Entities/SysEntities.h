
/******************************************************************************
 *  @file   : SysEntities.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-10-23
 *  @brief  : 系统数据实体类集合
 ******************************************************************************/

#import "SFAObject.h"

#pragma mark -
#pragma mark Config

@interface Config : SFAObject

@property (copy) NSString *key;
@property (copy) NSString *value;

@end

#pragma mark -
#pragma mark Host

@interface Host : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *host;

@end

#pragma mark -
#pragma mark SysCode

/**
 *  系统字典数据类型
 */
typedef NS_ENUM(NSInteger, SysCodeType) {
  /**
   *  系统字典数据类型 - 医生职称类型（技术职称）
   */
  SysCodeTypeChiefPhysician = 1,
  /**
   *  系统字典数据类型 - 医院等级
   */
  SysCodeTypeHospitalLevel,
  /**
   *  系统字典数据类型 - 医生等级
   */
  SysCodeTypeDoctorLevel,
  /**
   *  系统字典数据类型 - 医生职称类型（教学职称）
   */
  SysCodeTypeProfessor,
  /**
   *  系统字典数据类型 - 组织架构职称
   */
  SysCodeTypeOrgPositionalTitle,
  /**
   *  系统字典数据类型 - 职务名称
   */
  SysCodeTypeJobTitle,
  /**
   *  系统字典数据类型 - 医生行政职务
   */
  SysCodeTypeAdminTitle,
  /**
   *  系统字典数据类型 - 接受度
   */
  SysCodeTypeAcceptLevel,
};

@interface SysCode : SFAObject

@property (copy) NSString    *Id;
@property        SysCodeType  type;
@property (copy) NSString    *content;

@end

#pragma mark -
#pragma mark LatestUpdateTime

typedef NS_ENUM(NSInteger, LatestUpdateTimeType) {
  LatestUpdateTimeTypeOrg = 1,
//  <#LatestUpdateTimeTypeOther#>
};

@interface LatestUpdateTime : SFAObject

@property (copy) NSString             *Id;
@property        LatestUpdateTimeType  type;
@property        long long             time;

@end
