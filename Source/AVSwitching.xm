#import <Foundation/Foundation.h>

%group VideoAndAudioModePatches
// Remove popup reminder 
%hook YTMPlayerHeaderViewController
- (bool)shouldDisplayHintForAudioVideoSwitch {
	return 0;
}
%end

%hook YTIPlayerResponse
- (id)ytm_audioOnlyUpsell {
    return nil;
}

- (BOOL)ytm_isAudioOnlyPlayable {
    return YES;
}

- (BOOL)isAudioOnlyAvailabilityBlocked {
    return NO;
}

- (void)setIsAudioOnlyAvailabilityBlocked:(BOOL)blocked{
    %orig(NO);
}

- (void)setYtm_isAudioOnlyPlayable:(BOOL)playable{
    %orig(YES);
}
%end

%hook YTMAudioVideoModeController
- (BOOL)isAudioOnlyBlocked {
    return NO;
}

- (void)setIsAudioOnlyBlocked:(BOOL)blocked {
    %orig(NO);
}

- (void)setSwitchAvailability:(long long)arg1 {
    %orig(1);
}
%end

%hook YTMQueueConfig
- (BOOL)isAudioVideoModeSupported {
    return YES;
}

- (void)setIsAudioVideoModeSupported:(BOOL)supported {
    %orig(YES);
}

- (bool)noVideoModeEnabledForMusic {
	return 1;
}

- (bool)noVideoModeEnabledForPodcasts {
	return 1;
}

/*
- (BOOL)noVideoModeEnabled {
    return YES;
}

- (void)setNoVideoModeEnabled:(BOOL)enabled {
    %orig(YES);
}
*/
%end

%hook YTQueueController
- (bool)noVideoModeEnabled:(id)arg1 {
	return 1;
}
%end

%hook YTDefaultQueueConfig
- (BOOL)isAudioVideoModeSupported {
    return YES;
}

- (void)setIsAudioVideoModeSupported:(BOOL)supported {
    %orig(YES);
}

- (bool)noVideoModeEnabledForMusic {
	return 1;
}

- (bool)noVideoModeEnabledForPodcasts {
	return 1;
}
%end

%hook YTMSettings
- (BOOL)allowAudioOnlyManualQualitySelection {
    return YES;
}

- (BOOL)initialFormatAudioOnly {
    return YES;
}

- (BOOL)noVideoModeEnabled{
    return YES;
}

- (void)setNoVideoModeEnabled:(BOOL)enabled {
    %orig(YES);
}
%end

%hook YTIAudioConfig
- (BOOL)hasPlayAudioOnly {
    return YES;
}

- (BOOL)playAudioOnly {
    return YES;
}
%end

%hook YTIAudioOnlyPlayabilityRenderer
- (BOOL)audioOnlyPlayability {
    return YES;
}

- (int)audioOnlyAvailability {
    return 1;
}

- (void)setAudioOnlyPlayability:(BOOL)playability {
    %orig(YES);
}

- (id)infoRenderer {
    return nil;
}

- (BOOL)hasInfoRenderer {
    return NO;
}
%end

%hook YTIAudioOnlyPlayabilityRenderer_AudioOnlyPlayabilityInfoSupportedRenderers
- (id)upsellDialogRenderer {
    return nil;
}

- (void)setUpsellDialogRenderer:(id)renderer {
    return;
}
%end

%hook YTUserDefaults
- (BOOL)noVideoModeEnabled {
    return YES;
}

- (void)setNoVideoModeEnabled:(BOOL)enabled {
    %orig(YES);
}
%end

%hook YTQueueItem
- (BOOL)supportsAudioVideoSwitching {
    return YES;
}
%end

%hook YTMMusicAppMetadata
- (BOOL)isAudioOnlyButtonVisible {
    return YES;
}
%end
%end

%ctor {
    BOOL isEnabled = ([[NSUserDefaults standardUserDefaults] objectForKey:@"YTMUltimateIsEnabled"] != nil) ? [[NSUserDefaults standardUserDefaults] boolForKey:@"YTMUltimateIsEnabled"] : YES;

    if (isEnabled){
        %init(VideoAndAudioModePatches);
    }
}