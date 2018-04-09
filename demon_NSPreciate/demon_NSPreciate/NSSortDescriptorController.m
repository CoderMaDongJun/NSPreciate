//
//  NSSortDescriptorController.m
//  demon_NSPreciate
//
//  Created by 马栋军 on 2018/4/9.
//  Copyright © 2018年 BruceZhu. All rights reserved.
// https://www.jianshu.com/p/3e9f0884be6b
// 参考博客：https://www.cnblogs.com/Walking-Jin/p/5468371.html

#import "NSSortDescriptorController.h"
#import "Person.h"

@interface NSNumber (mySort)

- (NSComparisonResult)mySort:(NSNumber *)num;
@end

@implementation NSNumber (mySort)
- (NSComparisonResult)mySort:(NSNumber *)num {
    
    if (self == num) {
        return NSOrderedSame;
    } else if (self > num) {
        // 当自身大于num时, 本应该返回 NSOrderedDescending , 这里反转其结果, 使返回 NSOrderedAscending
        return NSOrderedAscending;
    }else {
        return NSOrderedDescending;
    }
}
@end

@interface Person (mySort)

- (NSComparisonResult)compareByName:(Person*)p;
@end

@implementation Person (mySort)
- (NSComparisonResult)compareByName:(Person*)p {
    
    if (self.age == p.age) {
        return NSOrderedSame;
    } else if (self.age > p.age) {
        // 当自身大于num时, 本应该返回 NSOrderedDescending , 这里反转其结果, 使返回 NSOrderedAscending
        return NSOrderedAscending;
    }else {
        return NSOrderedDescending;
    }
}
@end

@interface NSSortDescriptorController ()
@property (nonatomic ,strong) NSArray *persons;
@end

@implementation NSSortDescriptorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    NSArray *persons = [Person randomInstance];
    self.persons = persons ;
    
    [self sortedArrayUsingSelecor_2];
}

#pragma mark - 排序:sortedArrayUsingDescriptors
// 可以用sortedArrayUsingDescriptors:方法实现把多个排序条件放到数组中，实现多条件排序，按数组先后顺序，先加入的优先级高
// 使用NSSortDesriptor进行数组排序有三步
// 1.创建一个用来排序的数组
// 2.创建一个排序条件，初始化中需要指定按照数组中对象的什么属性进行排序，升序或者降序
// 3.数组根据排序条件进行排序，得到一个排序之后的数组（如果是可变数组，不会生成新数组，还是本身）
- (void)sortedArrayUsingDescriptors_1
{
    //创建一个数组
    
//    NSArray *array = @[@"one", @"two", @"three", @"four", @"six"];
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5"];
    
    //创建一个排序条件，也就是一个NSSortDescriptor对象
    
    //其中第一个参数为数组中对象要按照什么属性来排序(比如自身、姓名，年龄等)
    
    //第二个参数为指定排序方式是升序还是降序
    
    //ascending  排序的意思，默认为YES 升序
    NSSortDescriptor *des = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
    
    NSArray *newArray = [array sortedArrayUsingDescriptors:@[des]];
    
    NSLog(@"%@",newArray);
}

- (void)sortedArrayUsingDescriptors_2
{
    //创建一个Person类
    
    Person *p1 = [[Person alloc] initWithName:@"zhonger" age:19];
    
    Person *p2 = [[Person alloc] initWithName:@"zhubada" age:11];
    
    Person *p3 = [[Person alloc] initWithName:@"zhubada" age:1];
    
    Person *p4 = [[Person alloc] initWithName:@"zhubada" age:33];
    
    Person *p5 = [[Person alloc] initWithName:@"hehehe" age:38];
    
    NSArray *person = @[p1, p2, p3, p4, p5];
    
    NSSortDescriptor *des1 = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    
    NSSortDescriptor *des2 = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:NO];
    
    NSArray *newArray1 = [person sortedArrayUsingDescriptors:@[des1,des2]];
    
    NSLog(@"%@",newArray1);
}

#pragma mark - sortedArrayUsingSelecor
// 使用的sortedArrayUsingSelecor:的方法，就不需要创建NSSortDescriptor
- (void)sortedArrayUsingSelecor_1
{
    NSArray *strArray = @[@"zhonger", @"zhubada", @"qiuxiang", @"tangbohu", @"honghuang"];
    NSArray *nesStr = [strArray sortedArrayUsingSelector:@selector(compare:)];
    //SEL  只能用@selector（方法名）给定，并且，如果数组使用这个数组进行排序，此方法必须是返回值为NSComparisionResult
    
    NSLog(@"newStr is %@",nesStr);
}

- (void)sortedArrayUsingSelecor_2
{
    Person *p1 = [[Person alloc] initWithName:@"zhonger" age:19];
    
    Person *p2 = [[Person alloc] initWithName:@"zhubada" age:11];
    
    Person *p3 = [[Person alloc] initWithName:@"zhubada" age:1];
    
    Person *p4 = [[Person alloc] initWithName:@"zhubada" age:33];
    
    Person *p5 = [[Person alloc] initWithName:@"hehehe" age:38];
    
    NSArray *persons = @[p1,p2,p3,p4,p5];
    
    NSArray *personNewArray = [persons sortedArrayUsingSelector:@selector(compareByName:)];
    
    NSLog(@"--%@",personNewArray);
}

- (NSMutableArray *)getPersons
{
    NSArray *names = @[@"夏侯惇", @"貂蝉", @"诸葛亮", @"张三", @"李四", @"流火绯瞳", @"流火", @"李白", @"张飞", @"韩信", @"范冰冰", @"赵丽颖"];
    NSArray *ages = @[@32, @32, @45, @32, @32, @27, @15, @67, @55, @34, @44, @30];
    NSArray *heights = @[@170, @163, @180, @165, @163, @176, @174, @183, @186, @178, @167, @160];
    
    NSMutableArray *persons = [NSMutableArray arrayWithCapacity:names.count];
    for (int i = 0; i<names.count; i++) {
        
        Person *pe = [[Person alloc]init];
        pe.name = names[i];
        pe.age = [ages[i] intValue];
        pe.height = [heights[i] doubleValue];
        [persons addObject:pe];
    }
    return persons;
}

- (void)sortedArrayUsingSelecor_3
{
    NSMutableArray *persons = [self getPersons];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES selector:@selector(mySort:)];
    [persons sortUsingDescriptors:@[sort]];
    
    // 输出排序结果
    for (Person *p in persons) {
        NSLog(@"age: %zd,height: %zd name: %@", p.age,p.height, p.name);
    }
}

- (void)sortedArrayUsingSelecor_4
{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES comparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        if (obj1 == obj2) {
            return NSOrderedSame;
        } else if (obj1 > obj2){
            // 当obj1大于obj2时, 本应该返回 NSOrderedDescending , 这里反转其结果, 使返回 NSOrderedAscending
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    NSMutableArray *persons = [self getPersons];
    [persons sortUsingDescriptors:@[sort]];
    
    // 输出排序结果
    for (Person *people in persons) {
        NSLog(@"age: %zd,height: %zd name: %@", people.age,people.height, people.name);
    }
}
@end
