//
//  TLGroupCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLGroupCell.h"

#define     FRIENDS_SPACE_X         10.0f
#define     FRIENDS_SPACE_Y         9.5f

@interface TLGroupCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *usernameLabel;

@end

@implementation TLGroupCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftSeparatorSpace = FRIENDS_SPACE_X;
        
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.usernameLabel];
        
        [self p_addMasonry];
    }
    return self;
}

- (void) setGroup:(TLGroup *)group
{
    _group = group;
    if (group.groupAvatarPath.length == 0) {
        [TLUIUtility getGroupAvatarByGroupUsers:group.users finished:^(NSString *avatarPath) {
            group.groupAvatarPath = avatarPath;
            NSString *path = [NSFileManager pathUserChatAvatar:group.groupAvatarPath];
            [self.avatarImageView setImage:[UIImage imageNamed:path]];
        }];
        [self.avatarImageView setImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    else {
        NSString *path = [NSFileManager pathUserChatAvatar:group.groupAvatarPath];
        [self.avatarImageView setImage:[UIImage imageNamed:path]];
    }

    [self.usernameLabel setText:group.groupName];
}

#pragma mark - Private Methods -
- (void) p_addMasonry
{
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FRIENDS_SPACE_X);
        make.top.mas_equalTo(FRIENDS_SPACE_Y);
        make.bottom.mas_equalTo(- FRIENDS_SPACE_Y + 0.5);
        make.width.mas_equalTo(self.avatarImageView.mas_height);
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(FRIENDS_SPACE_X);
        make.centerY.mas_equalTo(self.avatarImageView);
        make.right.mas_lessThanOrEqualTo(self.contentView).mas_offset(-20);
    }];
}

#pragma mark - Getter
- (UIImageView *) avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
    }
    return _avatarImageView;
}

- (UILabel *) usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setFont:[UIFont fontFriendsUsername]];
    }
    return _usernameLabel;
}


@end
