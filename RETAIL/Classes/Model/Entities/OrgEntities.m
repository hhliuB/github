
/******************************************************************************
 *  @file   : OrgEntities.m
 *  @author : CUI ZHENSONG
 *  @date   : 2014-09-23
 *  @brief  : 架构数据实体类集合
 ******************************************************************************/

#import "OrgEntities.h"

#pragma mark -
#pragma mark ContectInfo -- 联系信息

@implementation ContectInfo

@end


#pragma mark -
#pragma mark Post -- 岗位

@implementation Post

@end

#pragma mark -
#pragma mark Employee -- 员工

@implementation Employee

- (id)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super initWithDictionary:dictionary];
  
  if (self) {
    if (!_Id) {
      _Id = self.undefinedProperties[@"EmployeeId"];
    }
    
    if (!_name) {
      _name = self.undefinedProperties[@"EmployeeName"];
    }
    
    if (!_avatarUrl) {
      _avatarUrl = self.undefinedProperties[@"Avatar"];
    }
    
    if (!_pinyin) {
      _pinyin = [_name pinyin];
    }
  }
  
  return self;
}

- (BOOL)isEqualToEmployee:(Employee *)employee
{
  return [self.Id isEqualToString:employee.Id];
}

@end

#pragma mark Subordinate -- 下属

@implementation Subordinate

@end

#pragma mark Manager -- 老板

@implementation Manager

@end

#pragma mark -
#pragma mark Post_Employee -- 岗位员工关系

@implementation Post_Employee

@end

#pragma mark -
#pragma mark Department -- 部门

@implementation Department

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super initWithDictionary:dictionary];
  
  if (self) {
    if (!_parent) {
      _parent = self.undefinedProperties[@"ParentDepartmentId"];
    }
    
    if (!_ename) {
      _ename = self.undefinedProperties[@"EName"];
    }
    
    if (!_info) {
      _info = self.undefinedProperties[@"Description"];
    }
  }
  
  return self;
}

@end

#pragma mark -
#pragma mark Product -- 产品

@implementation Product

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super initWithDictionary:dictionary];
  
  if (self) {
    if (!_ename) {
      _ename = self.undefinedProperties[@"EName"];
    }
    
    if (!_info) {
      _info = self.undefinedProperties[@"Description"];
    }
    
    if (!_logoUrl) {
      _logoUrl = self.undefinedProperties[@"Logo"];
    }
  }
  
  return self;
}

@end

#pragma mark -
#pragma mark Hospital -- 医院

@implementation Hospital

- (id)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super initWithDictionary:dictionary];
  
  if (self) {
    if (!_Id) {
      _Id = self.undefinedProperties[@"HospitalId"];
    }
    
    if (!_code) {
      _code = self.undefinedProperties[@"HospitalCode"];
    }
    
    if (!_name) {
      _name = self.undefinedProperties[@"HospitalName"];
    }
    
    if (!_levelId) {
      _levelId = self.undefinedProperties[@"HospitalLevelId"];
    }
    
    if (!_level) {
      _level = self.undefinedProperties[@"HospitalLevel"];
    }
    
    if (!_info) {
      _info = self.undefinedProperties[@"Description"];
    }
    
    if (!_pinyin) {
      _pinyin = [_name pinyin];
    }
    
    NSDictionary *gps = [self undefinedProperties][@"Gps"];
    if (gps) {
      _latitude  = [gps[@"Latitude"] floatValue];
      _longitude = [gps[@"Longitude"] floatValue];
    }
  }
  
  return self;
}

+ (NSArray *)propertiesOutOfDatabase
{
  return @[@"distance"];
}

@end

#pragma mark -
#pragma mark HospDepartment -- 科室

@implementation HospDepartment

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super initWithDictionary:dictionary];
  
  if (self) {
    if (!_info) {
      _info = self.undefinedProperties[@"Description"];
    }
  }
  
  return self;
}

@end

#pragma mark -
#pragma mark Doctor -- 医生

@implementation Doctor

- (id)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super initWithDictionary:dictionary];
  
  if (self) {
    if (!_Id) {
      _Id = self.undefinedProperties[@"DoctorId"];
    }
    
    if (!_info) {
      _info = self.undefinedProperties[@"Description"];
    }
    
    if (!_pinyin) {
      _pinyin = [_name pinyin];
    }
  }
  
  return self;
}

@end

#pragma mark -
#pragma mark HospDepartment_Doctor -- 科室医生关系

@implementation HospDepartment_Doctor

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super initWithDictionary:dictionary];
  
  if (self) {
    if (!_hospDepartmentId) {
      _hospDepartmentId = self.undefinedProperties[@"DepartmentId"];
    }
  }
  
  return self;
}

@end

#pragma mark -
#pragma mark DoctorProduct -- 医生产品分级

@implementation DoctorProduct

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super initWithDictionary:dictionary];
  
  if (self) {
    if (!_acceptLevelId) {
      _acceptLevelId = self.undefinedProperties[@"AcceptId"];
    }
    
    if (!_acceptLevel) {
      _acceptLevel = self.undefinedProperties[@"Accept"];
    }
  }
  
  return self;
}

@end

#pragma mark -
#pragma mark Post_Sales_Unit -- 岗位销售单元

@implementation Post_Sales_Unit

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super initWithDictionary:dictionary];
  
  if (self) {
    if (!_doctorProductId) {
      _doctorProductId = self.undefinedProperties[@"LevelId"];
    }
    
    if (!_acceptLevelId) {
      _acceptLevelId = self.undefinedProperties[@"AcceptId"];
    }
  }
  
  return self;
}

+ (NSArray *)propertiesOutOfDatabase
{
  return @[@"employeeName",
           @"hospitalName",
           @"doctorName",
           @"productName",
           @"employeePinyin",
           @"hospitalPinyin",
           @"doctorPinyin",
           @"productPinyin",
           @"level"];
}

@end



#pragma mark -
#pragma mark Terminal -- 终端

@implementation Terminal

@end

@implementation Contacts

@end
