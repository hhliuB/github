
/******************************************************************************
 *  @file   : OrgEntities.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-23
 *  @brief  : 架构数据实体类集合
 ******************************************************************************/

#import <Foundation/Foundation.h>

#import "SFAObject.h"

#pragma mark -
#pragma mark ContectInfo -- 联系信息

typedef NS_ENUM(NSInteger, ContectInfoType) {
  ContectInfoTypeEMail = 1,
  ContectInfoTypeTel,
  ContectInfoTypeMobile,
  ContectInfoTypeAddress,
  ContectInfoTypePostCode
};

typedef NS_ENUM(NSInteger, ContectInfoRelationType) {
  ContectInfoRelationTypeHospital = 1,
  ContectInfoRelationTypeHospDepartment,
  ContectInfoRelationTypeDoctor,
  ContectInfoRelationTypeEmployee
};

@interface ContectInfo : SFAObject

@property (copy) NSString                *Id;
@property        ContectInfoType          type;
@property (copy) NSString                *content;
@property (copy) NSString                *relationId;
@property        ContectInfoRelationType  relationType;

@end

#pragma mark -
#pragma mark Post -- 岗位

/**
 *  岗位类型
 */
typedef NS_ENUM(NSInteger, PostType) {
  /**
   *  岗位类型 - 其他
   */
  PostTypeOther,
  /**
   *  岗位类型 - 销售代表（MR）
   */
  PostTypeMR,
  /**
   *  岗位类型 - 一线经理（DSM）
   */
  PostTypeDSM
};

typedef NS_ENUM(NSInteger, PostStatus) {
  PostStatusDisabled,
  PostStatusEnabled
};

@interface Post : SFAObject

@property (copy) NSString   *Id;
@property (copy) NSString   *buId;
@property (copy) NSString   *departmentId;
@property (copy) NSString   *name;
@property (copy) NSString   *code;
@property (copy) NSString   *directParent;
@property        BOOL        isInSalesTeam;
@property (copy) NSString   *remark;
@property        PostType    type;
@property        PostStatus  status;

@end

#pragma mark -
#pragma mark Employee -- 员工

typedef NS_ENUM(NSInteger, Gender) {
  GenderUnknown,
  Male,
  Female
};

typedef NS_ENUM(NSInteger, EmployeeStatus) {
  EmployeeStatusDisabled,
  EmployeeStatusEnabled
};

@interface Employee : SFAObject

@property (copy) NSString       *Id;
@property (copy) NSString       *firstName;
@property (copy) NSString       *lastName;
@property (copy) NSString       *name;
@property (copy) NSString       *pinyin;
@property (copy) NSString       *avatarUrl;
@property        Gender          gender;
@property        EmployeeStatus  status;
@property        long long       entryDate;
@property        long long       departureDate;
@property        long long       birthday;
@property (copy) NSString       *remark;
@property (copy) NSString       *identityCode;

- (BOOL)isEqualToEmployee:(Employee *)employee;

@end

#pragma mark Subordinate -- 下属

@interface Subordinate : Employee

@end

#pragma mark Manager -- 老板

@interface Manager : Employee

@end

#pragma mark -
#pragma mark Post_Employee -- 岗位员工关系

@interface Post_Employee : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *postId;
@property (copy) NSString *employeeId;

@end

#pragma mark -
#pragma mark Department -- 部门

/**
 *  部门类型
 */
typedef NS_ENUM(NSInteger, DepartmentType) {
  /**
   *  部门类型 - 销售部门
   */
  DepartmentTypeSales = 1,
  /**
   *  部门类型 - 非销售部门
   */
  DepartmentTypeNonSales,
};

typedef NS_ENUM(NSInteger, DepartmentStatus) {
  DepartmentStatusEnumUnknown
};

@interface Department : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *parent;
@property (copy) NSString *code;
@property (copy) NSString *name;
@property (copy) NSString *ename;
@property (copy) NSString *managerPost;
@property (copy) NSString *info;

@property DepartmentType   type;
@property DepartmentStatus status;

@end

#pragma mark -
#pragma mark Product -- 产品

typedef NS_ENUM(NSInteger, ProductDosageForm) {
  ProductDosageFormEnumUnknown
};

/**
 *  药品销售类型
 */
typedef NS_ENUM(NSInteger, ProductSaleType) {
  /**
   *  药品销售类型 - 处方药
   */
  ProductSaleTypePrescription = 1,
  /**
   *  药品销售类型 - 非处方药
   */
  ProductSaleTypeNonPrescription,
  /**
   *  药品销售类型 - 保健品
   */
  ProductSaleTypeHealthProduct,
  /**
   *  药品销售类型 - 其他
   */
  ProductSaleTypeOther,
};

/**
 *  药品制造类型
 */
typedef NS_ENUM(NSInteger, ProductManufactureType) {
  /**
   *  药品制造类型 - 仿制药
   */
  ProductManufactureTypeGenerics = 1,
  /**
   *  药品制造类型 - 原研药
   */
  ProductManufactureTypeOriginal,
  /**
   *  药品制造类型 - 专利药
   */
  ProductManufactureTypePatent,
  /**
   *  药品制造类型 - 其他
   */
  ProductManufactureTypeOther,
};

/**
 *  药品材料类型
 */
typedef NS_ENUM(NSInteger, ProductMaterialType) {
  /**
   *  药品材料类型 - 成品药
   */
  ProductMaterialTypeFinishedDrug = 1,
  /**
   *  药品材料类型 - 原料药
   */
  ProductMaterialTypeRaw,
  /**
   *  药品材料类型 - 制剂
   */
  ProductMaterialTypePreparations,
  /**
   *  药品材料类型 - 其他
   */
  ProductMaterialTypeOther,
};

@interface Product : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *name;
@property (copy) NSString *ename;
@property (copy) NSString *abbreviation;
@property (copy) NSString *code;
@property (copy) NSString *info;
@property (copy) NSString *logoUrl;

@property ProductDosageForm      dosageForm;
@property ProductSaleType        saleType;
@property ProductManufactureType manufactureType;
@property ProductMaterialType    materialType;

@property (copy)   NSString *specification;
@property (assign) CGFloat   price;

@end

#pragma mark -
#pragma mark Hospital -- 医院

typedef NS_ENUM(NSInteger, HospitalStatus) {
  HospitalStatusEnumUnknown
};

/**
 *  医院数据来源
 */
typedef NS_ENUM(NSInteger, HospitalDataSource) {
  /**
   *  医院数据源 - 公司核心数据
   */
  HospitalDataSourceCompany,
  /**
   *  医院数据源 - 客户录入
   */
  HospitalDataSourceCustomerInput,
  /**
   *  医院数据源 - 客户导入
   */
  HospitalDataSourceCustomerImport,
};

@interface Hospital : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *parentId;
@property (copy) NSString *code;
@property (copy) NSString *name;
@property (copy) NSString *pinyin;
@property (copy) NSString *provinceId;
@property (copy) NSString *province;
@property (copy) NSString *cityId;
@property (copy) NSString *city;
@property (copy) NSString *levelId;
@property (copy) NSString *level;
@property (copy) NSString *feature;
@property (copy) NSString *info;

@property HospitalStatus     status;
@property HospitalDataSource dataSource;

@property double longitude;
@property double latitude;

@property NSInteger departmentCount;
@property NSInteger doctorCount;

// 不入库
@property double distance;

@end

#pragma mark -
#pragma mark HospDepartment -- 科室

typedef NS_ENUM(NSInteger, HospDepartmentStatus) {
  HospDepartmentStatusDisabled,
  HospDepartmentStatusEnabled
};

@interface HospDepartment : SFAObject

@property (copy) NSString             *Id;
@property (copy) NSString             *name;
@property (copy) NSString             *hospitalId;
@property (copy) NSString             *info;
@property        HospDepartmentStatus status;
@property        NSInteger            doctorCount;

@end

#pragma mark -
#pragma mark Doctor -- 医生

typedef NS_ENUM(NSInteger, DoctorStatus) {
  DoctorStatusDisabled,
  DoctorStatusEnabled
};

/**
 *  医生数据来源
 */
typedef NS_ENUM(NSInteger, DoctorDataSource) {
  /**
   *  医生数据来源 - 公司核心数据
   */
  DoctorDataSourceCompany,
  /**
   *  医生数据来源 - 客户录入
   */
  DoctorDataSourceCustomerInput,
  /**
   *  医生数据来源 - 客户导入
   */
  DoctorDataSourceCustomerImport
};

@interface Doctor : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *name;
@property (copy) NSString *pinyin;
@property        Gender    gender;
@property (copy) NSString *info;
@property (copy) NSString *hobby;

@property DoctorStatus     status;
@property DoctorDataSource dataSource;

@end

#pragma mark -
#pragma mark HospDepartment_Doctor -- 科室医生关系

@interface HospDepartment_Doctor : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *hospDepartmentId;
@property (copy) NSString *doctorId;
@property (copy) NSString *hospitalId;
/**
 *  职称Id
 */
@property (copy) NSString *chiefPhysicianId;
/**
 *  职称
 */
@property (copy) NSString *chiefPhysician;
/**
 *  教学职称Id
 */
@property (copy) NSString *professorId;
/**
 *  教学职称
 */
@property (copy) NSString *professor;
/**
 *  职位（医生/护士）Id
 */
@property (copy) NSString *jobTitleId;
/**
 *  职位（医生/护士）
 */
@property (copy) NSString *jobTitle;
/**
 *  行政岗位Id
 */
@property (copy) NSString *adminTitleId;
/**
 *  行政岗位
 */
@property (copy) NSString *adminTitle;
@property (copy) NSString *remark;

@end

#pragma mark -
#pragma mark DoctorProduct -- 医生产品分级

@interface DoctorProduct : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *doctorId;
@property (copy) NSString *productId;
@property (copy) NSString *hospitalId;
@property (copy) NSString *levelId;
@property (copy) NSString *level;
@property (copy) NSString *acceptLevelId;
@property (copy) NSString *acceptLevel;

@end

#pragma mark -
#pragma mark Post_Sales_Unit -- 岗位销售单元

@interface Post_Sales_Unit : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *postId;
@property (copy) NSString *hospitalId;
@property (copy) NSString *doctorId;
@property (copy) NSString *productId;
@property (copy) NSString *doctorProductId;
@property (copy) NSString *acceptLevelId;

// 不入库
@property (copy) NSString *employeeName;
@property (copy) NSString *hospitalName;
@property (copy) NSString *doctorName;
@property (copy) NSString *productName;
@property (copy) NSString *employeePinyin;
@property (copy) NSString *hospitalPinyin;
@property (copy) NSString *doctorPinyin;
@property (copy) NSString *productPinyin;
@property (copy) NSString *level;

@end


// 测试实体

#pragma mark -
#pragma mark Terminal -- 终端

@interface Terminal : SFAObject

@property (copy)   NSString *Id;
@property (copy)   NSString *name;
@property (copy)   NSString *pinyin;
@property (copy)   NSString *address;

@property (assign) NSInteger level; // [0, 2]

@property (assign) NSInteger distanceFromPrevTerminal;
@property (assign) NSInteger distanceFromMe;

@end

#pragma mark -
#pragma mark Contacts -- 联系人

@interface Contacts : SFAObject

@property (copy) NSString *Id;
@property (copy) NSString *name;
@property (copy) NSString *gender;
@property (copy) NSString *role;
@property (copy) NSString *phoneNumber;

@end
