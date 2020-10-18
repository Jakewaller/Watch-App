//
//  ContentView.swift
//  Watch App WatchKit Extension
//
//  Created by Jake Thomas Waller on 2020-10-18.
//  Copyright © 2020 Jake Thomas Waller. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("JakeWaller.ipa")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
/*    CFPlugIn.h
    Copyright (c) 1999-2019, Apple Inc. and the Swift project authors
 
    Portions Copyright (c) 2014-2019, Apple Inc. and the Swift project authors
    Licensed under Apache License v2.0 with Runtime Library Exception
    See http://swift.org/LICENSE.txt for license information
    See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
*/

#if !defined(__COREFOUNDATION_CFPLUGIN__)
#define __COREFOUNDATION_CFPLUGIN__ 1

#if !defined(COREFOUNDATION_CFPLUGINCOM_SEPARATE)
#define COREFOUNDATION_CFPLUGINCOM_SEPARATE 1
#endif

#include <CoreFoundation/CFBase.h>
#include <CoreFoundation/CFArray.h>
#include <CoreFoundation/CFBundle.h>
#include <CoreFoundation/CFString.h>
#include <CoreFoundation/CFURL.h>
#include <CoreFoundation/CFUUID.h>

CF_IMPLICIT_BRIDGING_ENABLED
CF_EXTERN_C_BEGIN

/* ================ Standard Info.plist keys for plugIns ================ */

CF_EXPORT const CFStringRef kCFPlugInDynamicRegistrationKey;
CF_EXPORT const CFStringRef kCFPlugInDynamicRegisterFunctionKey;
CF_EXPORT const CFStringRef kCFPlugInUnloadFunctionKey;
CF_EXPORT const CFStringRef kCFPlugInFactoriesKey;
CF_EXPORT const CFStringRef kCFPlugInTypesKey;

/* ================= Function prototypes for various callbacks ================= */
/* Function types that plugIn authors can implement for various purposes. */

typedef void (*CFPlugInDynamicRegisterFunction)(CFPlugInRef plugIn);
typedef void (*CFPlugInUnloadFunction)(CFPlugInRef plugIn);
typedef void *(*CFPlugInFactoryFunction)(CFAllocatorRef allocator, CFUUIDRef typeUUID);

/* ================= Creating PlugIns ================= */

CF_EXPORT CFTypeID CFPlugInGetTypeID(void);

CF_EXPORT CFPlugInRef CFPlugInCreate(CFAllocatorRef allocator, CFURLRef plugInURL);
    /* Might return an existing instance with the ref-count bumped. */

CF_EXPORT CFBundleRef CFPlugInGetBundle(CFPlugInRef plugIn);

/* ================= Controlling load on demand ================= */
/* For plugIns. */
/* PlugIns that do static registration are load on demand by default. */
/* PlugIns that do dynamic registration are not load on demand by default. */
/* A dynamic registration function can call CFPlugInSetLoadOnDemand(). */

CF_EXPORT void CFPlugInSetLoadOnDemand(CFPlugInRef plugIn, Boolean flag);

CF_EXPORT Boolean CFPlugInIsLoadOnDemand(CFPlugInRef plugIn);

/* ================= Finding factories and creating instances ================= */
/* For plugIn hosts. */
/* Functions for finding factories to create specific types and actually creating instances of a type. */

/* This function finds all the factories from any plugin for the given type.  Returns an array that the caller must release. */
CF_EXPORT CFArrayRef CFPlugInFindFactoriesForPlugInType(CFUUIDRef typeUUID) CF_RETURNS_RETAINED;


/* This function restricts the result to factories from the given plug-in that can create the given type.  Returns an array that the caller must release. */
CF_EXPORT CFArrayRef CFPlugInFindFactoriesForPlugInTypeInPlugIn(CFUUIDRef typeUUID, CFPlugInRef plugIn) CF_RETURNS_RETAINED;

/* This function returns the IUnknown interface for the new instance. */
CF_EXPORT void *CFPlugInInstanceCreate(CFAllocatorRef allocator, CFUUIDRef factoryUUID, CFUUIDRef typeUUID);

/* ================= Registering factories and types ================= */
/* For plugIn writers who must dynamically register things. */
/* Functions to register factory functions and to associate factories with types. */

CF_EXPORT Boolean CFPlugInRegisterFactoryFunction(CFUUIDRef factoryUUID, CFPlugInFactoryFunction func);

CF_EXPORT Boolean CFPlugInRegisterFactoryFunctionByName(CFUUIDRef factoryUUID, CFPlugInRef plugIn, CFStringRef functionName);

CF_EXPORT Boolean CFPlugInUnregisterFactory(CFUUIDRef factoryUUID);

CF_EXPORT Boolean CFPlugInRegisterPlugInType(CFUUIDRef factoryUUID, CFUUIDRef typeUUID);

CF_EXPORT Boolean CFPlugInUnregisterPlugInType(CFUUIDRef factoryUUID, CFUUIDRef typeUUID);

/* ================= Registering instances ================= */
/* When a new instance of a type is created, the instance is responsible for registering itself with the factory that created it and unregistering when it deallocates. */
/* This means that an instance must keep track of the CFUUIDRef of the factory that created it so it can unregister when it goes away. */

CF_EXPORT void CFPlugInAddInstanceForFactory(CFUUIDRef factoryID);

CF_EXPORT void CFPlugInRemoveInstanceForFactory(CFUUIDRef factoryID);


/* Obsolete API */

typedef struct CF_BRIDGED_TYPE(id) __CFPlugInInstance *CFPlugInInstanceRef;

typedef Boolean (*CFPlugInInstanceGetInterfaceFunction)(CFPlugInInstanceRef instance, CFStringRef interfaceName, void **ftbl);
typedef void (*CFPlugInInstanceDeallocateInstanceDataFunction)(void *instanceData);

CF_EXPORT Boolean CFPlugInInstanceGetInterfaceFunctionTable(CFPlugInInstanceRef instance, CFStringRef interfaceName, void **ftbl);

/* This function returns a retained object on 10.8 or later. */
CF_EXPORT CFStringRef CFPlugInInstanceGetFactoryName(CFPlugInInstanceRef instance) CF_RETURNS_RETAINED;

CF_EXPORT void *CFPlugInInstanceGetInstanceData(CFPlugInInstanceRef instance);

CF_EXPORT CFTypeID CFPlugInInstanceGetTypeID(void);

CF_EXPORT CFPlugInInstanceRef CFPlugInInstanceCreateWithInstanceDataSize(CFAllocatorRef allocator, CFIndex instanceDataSize, CFPlugInInstanceDeallocateInstanceDataFunction deallocateInstanceFunction, CFStringRef factoryName, CFPlugInInstanceGetInterfaceFunction getInterfaceFunction);

CF_EXTERN_C_END
CF_IMPLICIT_BRIDGING_DISABLED

#if !COREFOUNDATION_CFPLUGINCOM_SEPARATE
#include <CoreFoundation/CFPlugInCOM.h>
#endif /* !COREFOUNDATION_CFPLUGINCOM_SEPARATE */

#endif /* ! __COREFOUNDATION_CFPLUGIN__ */

/*
     File:       CFNetwork/CFProxySupport.h
 
     Contains:   Support for computing which proxy applies when
 
     Copyright:  Copyright (c) 2006-2013 Apple Inc. All rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFPROXYSUPPORT__
#define __CFPROXYSUPPORT__

#ifndef __CFNETWORKDEFS__
#include <CFNetwork/CFNetworkDefs.h>
#endif

#ifndef __CFARRAY__
#include <CoreFoundation/CFArray.h>
#endif

#ifndef __CFSTRING__
#include <CoreFoundation/CFString.h>
#endif

#ifndef __CFURL__
#include <CoreFoundation/CFURL.h>
#endif

#ifndef __CFERROR__
#include <CoreFoundation/CFError.h>
#endif

#ifndef __CFRUNLOOP__
#include <CoreFoundation/CFRunLoop.h>
#endif

#ifndef __CFSTREAM__
#include <CoreFoundation/CFStream.h>
#endif


/*
    These APIs return arrays of dictionaries, where each dictionary describes a single proxy.
    The arrays represent the order in which the proxies should be tried - try to download the URL
    using the first entry in the array, and if that fails, try using the second entry, and so on.

    The keys to the proxy dictionaries follow the function declarations; every proxy dictionary
    will have an entry for kCFProxyTypeKey.  If the type is anything except
    kCFProxyTypeAutoConfigurationURL, the dictionary will also have entries for the proxy's host
    and port (under kCFProxyHostNameKey and kCFProxyPortNumberKey respectively).  If the type is
    kCFProxyTypeAutoConfigurationURL, it will have an entry for kCFProxyAutoConfigurationURLKey.
    
    The keys for username and password are optional and will only be present if the username
    or password could be extracted from the information passed in (i.e. either the URL itself
    or the proxy dictionary supplied).  These APIs do not consult any external credential stores
    (such as the Keychain).
*/


#if PRAGMA_ONCE
#pragma once
#endif

CF_EXTERN_C_BEGIN
CF_ASSUME_NONNULL_BEGIN

/*!
    @function CFNetworkCopySystemProxySettings
    @discussion Returns a CFDictionary containing the current system internet proxy settings.
    @result Returns a dictionary containing key-value pairs that represent
        the current internet proxy settings.  See below for definitions of the keys and
        values.
        NULL if no proxy settings have been defined or if an error
        was encountered.
        The caller is responsible for releasing the returned dictionary.
*/
CFN_EXPORT __nullable CFDictionaryRef
CFNetworkCopySystemProxySettings(void) CF_AVAILABLE(10_6, 2_0);

    
/*
 *  CFNetworkCopyProxiesForURL()
 *
 *  Discussion:
 *    Given a URL and a proxy dictionary, determines the ordered list
 *    of proxies that should be used to download the given URL.
 *
 *  Parameters:
 *
 *    url:
 *      The URL to be accessed
 *
 *    proxySettings:
 *      A dictionary describing the available proxy settings; the
 *      dictionary's format should match the dictionary returned
 *      by CFNetworkCopySystemProxySettings described below.
 *
 *  Result:
 *    An array of dictionaries; each dictionary describes a single
 *    proxy.  See the comment at the top of this file for how to
 *    interpret the returned dictionaries.
 *
 */
CFN_EXPORT CFArrayRef
CFNetworkCopyProxiesForURL(CFURLRef url, CFDictionaryRef proxySettings) CF_AVAILABLE(10_5, 2_0);




/*
 *  CFProxyAutoConfigurationResultCallback
 *
 *  Discussion:
 *    Callback function to be called when a PAC file computation
 *    (initiated by either CFNetworkExecuteProxyAutoConfigurationScript
 *    or CFNetworkExecuteProxyAutoConfigurationURL) has completed.
 *
 *  Parameters:
 *
 *    client:
 *      The client reference passed in to
 *      CFNetworkExecuteProxyAutoConfigurationScript or
 *      CFNetworkExecuteProxyAutoConfigurationURL
 *
 *    proxyList:
 *      Upon success, the list of proxies returned by the
 *      autoconfiguration script.  The list has the same format as
 *      returned by CFProxyCopyProxiesForURL, above, except that no
 *      entry may be of type kCFProxyTypeAutoConfigurationURL.  Note
 *      that if the client wishes to keep this list, they must retain
 *      it when they receive this callback.
 *
 *    error:
 *      Upon failure, an error object explaining the failure.
 */
typedef CALLBACK_API_C( void , CFProxyAutoConfigurationResultCallback )(void *client, CFArrayRef proxyList, CFErrorRef __nullable error);

/*
 *  CFNetworkCopyProxiesForAutoConfigurationScript()
 *
 *  Discussion:
 *    Synchronously executes the given proxy autoconfiguration script
 *    and returns a valid proxyList and NULL error upon success or a
 *    NULL proxyList and valid error on failure.
 *
 *  Parameters:
 *
 *    proxyAutoConfigurationScript:
 *      A CFString containing the code of the script to be executed.
 *
 *    targetURL:
 *      The URL that should be input in to the autoconfiguration script.
 *
 *    error:
 *      A return argument that will contain a valid error in case of
 *      failure.
 *
 *  Result:
 *    An array of dictionaries describing the proxies returned by the
 *    script or NULL on failure.
 *
 */
CFN_EXPORT __nullable CFArrayRef
CFNetworkCopyProxiesForAutoConfigurationScript(CFStringRef proxyAutoConfigurationScript, CFURLRef targetURL, CFErrorRef * __nullable error) CF_AVAILABLE(10_5, 2_0);


/*
 *  CFNetworkExecuteProxyAutoConfigurationScript()
 *
 *  Discussion:
 *    Begins the process of executing proxyAutoConfigurationScript to
 *    determine the correct proxy to use to retrieve targetURL.  The
 *    caller should schedule the returned run loop source; when the
 *    results are found, the caller's callback will be called via the
 *    run loop, passing a valid proxyList and NULL error upon success,
 *    or a NULL proxyList and valid error on failure.  The caller
 *    should invalidate the returned run loop source if it wishes to
 *    terminate the request before completion. The returned
 *    RunLoopSource will be removed from all run loops and modes on
 *    which it was scheduled after the callback returns.
 *
 *  Parameters:
 *
 *    proxyAutoConfigurationScript:
 *      A CFString containing the code of the script to be executed.
 *
 *    targetURL:
 *      The URL that should be passed to the autoconfiguration script.
 *
 *    cb:
 *      A client callback to notify the caller of completion.
 *
 *    clientContext:
 *      a stream context containing a client info object and optionally
 *      retain / release callbacks for said info object.
 *
 *  Result:
 *    A CFRunLoopSource which the client can use to schedule execution
 *    of the AutoConfiguration Script.
 *
 */
CFN_EXPORT CFRunLoopSourceRef
CFNetworkExecuteProxyAutoConfigurationScript(
  CFStringRef proxyAutoConfigurationScript,
  CFURLRef targetURL,
  CFProxyAutoConfigurationResultCallback cb,
  CFStreamClientContext * clientContext) CF_AVAILABLE(10_5, 2_0);



/*
 *  CFNetworkExecuteProxyAutoConfigurationURL()
 *
 *  Discussion:
 *    As CFNetworkExecuteProxyAutoConfigurationScript(), above, except
 *    that CFNetworkExecuteProxyAutoConfigurationURL will additionally
 *    download the contents of proxyAutoConfigURL, convert it to a
 *    JavaScript string, and then execute that script.
 *  Ownership for the returned CFRunLoopSourceRef follows the copy rule,
 *  the client is responsible for releasing the object.
 *
 */
CFN_EXPORT CFRunLoopSourceRef
CFNetworkExecuteProxyAutoConfigurationURL(
  CFURLRef proxyAutoConfigURL,
  CFURLRef targetURL,
  CFProxyAutoConfigurationResultCallback cb,
  CFStreamClientContext * clientContext) CF_AVAILABLE(10_5, 2_0);


/*
 *  kCFProxyTypeKey
 *
 *  Discussion:
 *    Key for the type of proxy being represented; value will be one of
 *    the kCFProxyType constants listed below.
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeKey CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyHostNameKey
 *
 *  Discussion:
 *    Key for the proxy's hostname; value is a CFString.  Note that
 *    this may be an IPv4 or IPv6 dotted-IP string.
 *
 */
CFN_EXPORT const CFStringRef kCFProxyHostNameKey CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyPortNumberKey
 *
 *  Discussion:
 *    Key for the proxy's port number; value is a CFNumber specifying
 *    the port on which to contact the proxy
 *
 */
CFN_EXPORT const CFStringRef kCFProxyPortNumberKey CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyAutoConfigurationURLKey
 *
 *  Discussion:
 *    Key for the proxy's PAC file location; this key is only present
 *    if the proxy's type is kCFProxyTypeAutoConfigurationURL.  Value
 *    is a CFURL specifying the location of a proxy auto-configuration
 *    file
 *
 */
CFN_EXPORT const CFStringRef kCFProxyAutoConfigurationURLKey CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyAutoConfigurationJavaScriptKey
 *
 *  Discussion:
 *    Key for the proxy's PAC script
 *    The value is a CFString that contains the full JavaScript soure text for the PAC file.
 *
 */
CFN_EXPORT const CFStringRef kCFProxyAutoConfigurationJavaScriptKey CF_AVAILABLE(10_7, 3_0);


/*
 *  kCFProxyUsernameKey
 *
 *  Discussion:
 *    Key for the username to be used with the proxy; value is a
 *    CFString. Note that this key will only be present if the username
 *    could be extracted from the information passed in.  No external
 *    credential stores (like the Keychain) are consulted.
 *
 */
CFN_EXPORT const CFStringRef kCFProxyUsernameKey CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyPasswordKey
 *
 *  Discussion:
 *    Key for the password to be used with the proxy; value is a
 *    CFString. Note that this key will only be present if the username
 *    could be extracted from the information passed in.  No external
 *    credential stores (like the Keychain) are consulted.
 *
 */
CFN_EXPORT const CFStringRef kCFProxyPasswordKey CF_AVAILABLE(10_5, 2_0);

/*
    Possible values for kCFProxyTypeKey:
    kCFProxyTypeNone - no proxy should be used; contact the origin server directly
    kCFProxyTypeHTTP - the proxy is an HTTP proxy
    kCFProxyTypeHTTPS - the proxy is a tunneling proxy as used for HTTPS
    kCFProxyTypeSOCKS - the proxy is a SOCKS proxy
    kCFProxyTypeFTP - the proxy is an FTP proxy
    kCFProxyTypeAutoConfigurationURL - the proxy is specified by a proxy autoconfiguration (PAC) file
*/

/*
 *  kCFProxyTypeNone
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeNone CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyTypeHTTP
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeHTTP CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyTypeHTTPS
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeHTTPS CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyTypeSOCKS
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeSOCKS CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyTypeFTP
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeFTP CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyTypeAutoConfigurationURL
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeAutoConfigurationURL CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyTypeAutoConfigurationJavaScript
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeAutoConfigurationJavaScript CF_AVAILABLE(10_7, 3_0);
    
/*
 *  kCFProxyAutoConfigHTTPResponse
 *
 */
CFN_EXPORT const CFStringRef kCFProxyAutoConfigurationHTTPResponseKey CF_AVAILABLE(10_5, 2_0);
    

#if TARGET_OS_MAC
/*
 *  kCFNetworkProxiesExceptionsList
 *
 *  Discussion:
 *    Key for the list of host name patterns that should bypass the proxy; value is a
 *    CFArray of CFStrings.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesExceptionsList CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesExcludeSimpleHostnames
 *
 *  Discussion:
 *    Key whose value indicates if simple hostnames will be excluded; value is a
 *    CFNumber.  Simple hostnames will be excluded if the key is present and has a
 *    non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesExcludeSimpleHostnames CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesFTPEnable
 *
 *  Discussion:
 *    Key for the enabled status of the ftp proxy; value is a
 *    CFNumber.  The proxy is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesFTPEnable CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesFTPPassive
 *
 *  Discussion:
 *    Key for the state of passive mode for the ftp proxy; value is a
 *    CFNumber.  A value of one indicates that passive mode is enabled, a value
 *    of zero indicates that passive mode is not enabled.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesFTPPassive CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesFTPPort
 *
 *  Discussion:
 *    Key for the port number associated with the ftp proxy; value is a
 *    CFNumber which is the port number.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesFTPPort CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesFTPProxy
 *
 *  Discussion:
 *    Key for the host name associated with the ftp proxy; value is a
 *    CFString which is the proxy host name.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesFTPProxy CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesGopherEnable
 *
 *  Discussion:
 *    Key for the enabled status of the gopher proxy; value is a
 *    CFNumber.  The proxy is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesGopherEnable CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesGopherPort
 *
 *  Discussion:
 *    Key for the port number associated with the gopher proxy; value is a
 *    CFNumber which is the port number.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesGopherPort CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesGopherProxy
 *
 *  Discussion:
 *    Key for the host name associated with the gopher proxy; value is a
 *    CFString which is the proxy host name.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesGopherProxy CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesHTTPEnable
 *
 *  Discussion:
 *    Key for the enabled status of the HTTP proxy; value is a
 *    CFNumber.  The proxy is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesHTTPEnable CF_AVAILABLE(10_6, 2_0);

/*
 *  kCFNetworkProxiesHTTPPort
 *
 *  Discussion:
 *    Key for the port number associated with the HTTP proxy; value is a
 *    CFNumber which is the port number.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesHTTPPort CF_AVAILABLE(10_6, 2_0);

/*
 *  kCFNetworkProxiesHTTPProxy
 *
 *  Discussion:
 *    Key for the host name associated with the HTTP proxy; value is a
 *    CFString which is the proxy host name.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesHTTPProxy CF_AVAILABLE(10_6, 2_0);

/*
 *  kCFNetworkProxiesHTTPSEnable
 *
 *  Discussion:
 *    Key for the enabled status of the HTTPS proxy; value is a
 *    CFNumber.  The proxy is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesHTTPSEnable CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesHTTPSPort
 *
 *  Discussion:
 *    Key for the port number associated with the HTTPS proxy; value is a
 *    CFNumber which is the port number.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesHTTPSPort CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesHTTPSProxy
 *
 *  Discussion:
 *    Key for the host name associated with the HTTPS proxy; value is a
 *    CFString which is the proxy host name.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesHTTPSProxy CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesRTSPEnable
 *
 *  Discussion:
 *    Key for the enabled status of the RTSP proxy; value is a
 *    CFNumber.  The proxy is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesRTSPEnable CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesRTSPPort
 *
 *  Discussion:
 *    Key for the port number associated with the RTSP proxy; value is a
 *    CFNumber which is the port number.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesRTSPPort CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesRTSPProxy
 *
 *  Discussion:
 *    Key for the host name associated with the RTSP proxy; value is a
 *    CFString which is the proxy host name.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesRTSPProxy CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesSOCKSEnable
 *
 *  Discussion:
 *    Key for the enabled status of the SOCKS proxy; value is a
 *    CFNumber.  The proxy is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesSOCKSEnable CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesSOCKSPort
 *
 *  Discussion:
 *    Key for the port number associated with the SOCKS proxy; value is a
 *    CFNumber which is the port number.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesSOCKSPort CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesSOCKSProxy
 *
 *  Discussion:
 *    Key for the host name associated with the SOCKS proxy; value is a
 *    CFString which is the proxy host name.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesSOCKSProxy CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesProxyAutoConfigEnable
 *
 *  Discussion:
 *    Key for the enabled status ProxyAutoConfig (PAC); value is a
 *    CFNumber.  ProxyAutoConfig is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesProxyAutoConfigEnable    CF_AVAILABLE(10_6, 2_0);

/*
 *  kCFNetworkProxiesProxyAutoConfigURLString
 *
 *  Discussion:
 *    Key for the url which indicates the location of the ProxyAutoConfig (PAC) file; value is a
 *    CFString which is url for the PAC file.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesProxyAutoConfigURLString CF_AVAILABLE(10_6, 2_0);

/*
 * kCFNetworkProxiesProxyAutoConfigJavaScript
 *
 * Discussion:
 * Key for the string which is the full JavaScript source of the ProxyAutoConfig (PAC) script;  value is a
 * CFString with is the full text source of the PAC script.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesProxyAutoConfigJavaScript    CF_AVAILABLE(10_7, 3_0);
    
/*
 *  kCFNetworkProxiesProxyAutoDiscoveryEnable
 *
 *  Discussion:
 *    Key for the enabled status of proxy auto discovery; value is a
 *    CFNumber.  Proxy auto discovery is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesProxyAutoDiscoveryEnable CF_AVAILABLE(10_6, NA);
#endif // TARGET_OS_MAC

CF_ASSUME_NONNULL_END
CF_EXTERN_C_END

#endif /* __CFPROXYSUPPORT__ */

[<#indexSet#> enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger index, BOOL *stop) {
    <#statements#>
}];
//
//  WKInterfaceController.h
//  WatchKit
//
//  Copyright (c) 2014-2015 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <WatchKit/WKDefines.h>
#import <UIKit/UIGeometry.h>

NS_ASSUME_NONNULL_BEGIN

@class WKAlertAction;
@class WKInterfaceTable;
@class WKInterfacePicker;
@class WKCrownSequencer;
@class WKInterfaceObject;
@class UIImage;
@class UILocalNotification;
@class PKPass;
@class UNNotification;
@class UNNotificationAction;

typedef NS_ENUM(NSInteger, WKUserNotificationInterfaceType)  {
    WKUserNotificationInterfaceTypeDefault,
    WKUserNotificationInterfaceTypeCustom,
} NS_ENUM_AVAILABLE_IOS(8_2);

typedef NS_ENUM(NSInteger, WKMenuItemIcon)  {
    WKMenuItemIconAccept,       // checkmark
    WKMenuItemIconAdd,          // '+'
    WKMenuItemIconBlock,        // circle w/ slash
    WKMenuItemIconDecline,      // 'x'
    WKMenuItemIconInfo,         // 'i'
    WKMenuItemIconMaybe,        // '?'
    WKMenuItemIconMore,         // '...'
    WKMenuItemIconMute,         // speaker w/ slash
    WKMenuItemIconPause,        // pause button
    WKMenuItemIconPlay,         // play button
    WKMenuItemIconRepeat,       // looping arrows
    WKMenuItemIconResume,       // circular arrow
    WKMenuItemIconShare,        // share icon
    WKMenuItemIconShuffle,      // swapped arrows
    WKMenuItemIconSpeaker,      // speaker icon
    WKMenuItemIconTrash,        // trash icon
} NS_ENUM_AVAILABLE_IOS(8_2);

typedef NS_ENUM(NSInteger, WKTextInputMode)  {
    WKTextInputModePlain,        // text (no emoji) from dictation + suggestions
    WKTextInputModeAllowEmoji,         // text plus non-animated emoji from dictation + suggestions
    WKTextInputModeAllowAnimatedEmoji API_DEPRECATED("Animated Emojis are no longer supported. Use WKTextInputModeAllowEmoji instead", watchos(2.0, 6.0))
};

typedef NS_ENUM(NSInteger, WKAlertControllerStyle) {
    WKAlertControllerStyleAlert,
    WKAlertControllerStyleSideBySideButtonsAlert,
    WKAlertControllerStyleActionSheet,
} WK_AVAILABLE_WATCHOS_ONLY(2.0);

typedef NS_ENUM(NSInteger, WKPageOrientation) {
    WKPageOrientationHorizontal,
    WKPageOrientationVertical,
} WK_AVAILABLE_WATCHOS_ONLY(4.0);

typedef NS_ENUM(NSInteger, WKInterfaceScrollPosition) {
    WKInterfaceScrollPositionTop,
    WKInterfaceScrollPositionCenteredVertically,
    WKInterfaceScrollPositionBottom
} WK_AVAILABLE_WATCHOS_ONLY(4.0);


typedef NS_ENUM(NSInteger, WKVideoGravity)  {
    WKVideoGravityResizeAspect,
    WKVideoGravityResizeAspectFill,
    WKVideoGravityResize
} WK_AVAILABLE_WATCHOS_ONLY(2.0);

/*
 The following presets can be specified to indicate the desired output sample rate. The resulting bit rate depends on the preset and the audio format. The audio file type is inferred from the output URL extension. The audio format is inferred from the audio file type. Supported file types include .wav, .mp4, and .m4a. When the URL extension is .wav, the audio format is LPCM. It is AAC for all other cases.
 */
typedef NS_ENUM(NSInteger, WKAudioRecorderPreset) {
    WKAudioRecorderPresetNarrowBandSpeech,    // @8kHz, LPCM 128kbps, AAC 24kbps
    WKAudioRecorderPresetWideBandSpeech,    // @16kHz, LPCM 256kbps, AAC 32kbps
    WKAudioRecorderPresetHighQualityAudio    // @44.1kHz, LPCM 705.6kbps, AAC 96kbps
} WK_AVAILABLE_WATCHOS_ONLY(2.0);

WK_CLASS_AVAILABLE_IOS(8_2)
@interface WKInterfaceController : NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (void)awakeWithContext:(nullable id)context;   // context from controller that did push or modal presentation. default does nothing

@property (nonatomic, readonly) CGRect contentFrame;
@property (nonatomic, strong, readonly) WKCrownSequencer *crownSequencer;

@property (nonatomic,readonly) UIEdgeInsets contentSafeAreaInsets WK_AVAILABLE_WATCHOS_ONLY(5.0);
@property (nonatomic,readonly) NSDirectionalEdgeInsets systemMinimumLayoutMargins WK_AVAILABLE_WATCHOS_ONLY(5.0);
@property (nonatomic, getter=isTableScrollingHapticFeedbackEnabled) BOOL tableScrollingHapticFeedbackEnabled WK_AVAILABLE_WATCHOS_ONLY(5.0); // enabled by default

- (void)willActivate;      // Called when watch interface is active and able to be updated. Can be called when interface is not visible.
- (void)didDeactivate;     // Called when watch interface is no longer active and cannot be updated.

- (void)didAppear WK_AVAILABLE_WATCHOS_ONLY(2.0);  // Called when watch interface is visible to user
- (void)willDisappear WK_AVAILABLE_WATCHOS_ONLY(2.0); // Called when watch interface is about to no longer be visible

- (void)pickerDidFocus:(WKInterfacePicker *)picker WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)pickerDidResignFocus:(WKInterfacePicker *)picker WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)pickerDidSettle:(WKInterfacePicker *)picker WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex;  // row selection if controller has WKInterfaceTable property
- (void)handleActionWithIdentifier:(nullable NSString *)identifier forNotification:(UNNotification *)notification WK_AVAILABLE_IOS_ONLY(10.0); // when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty

- (void)setTitle:(nullable NSString *)title;        // title of controller. displayed when controller active

- (void)pushControllerWithName:(NSString *)name context:(nullable id)context;  // context passed to child controller via awakeWithContext:
- (void)popController;
- (void)popToRootController;
- (void)scrollToObject:(WKInterfaceObject *)object atScrollPosition:(WKInterfaceScrollPosition)scrollPosition animated:(BOOL)animated WK_AVAILABLE_WATCHOS_ONLY(4.0);
- (void)interfaceDidScrollToTop WK_AVAILABLE_WATCHOS_ONLY(4.0); // Called when user tapped on status bar for scroll-to-top gesture and scrolling animation finished. May be called immediately if already at top
- (void)interfaceOffsetDidScrollToTop WK_AVAILABLE_WATCHOS_ONLY(4.0); // called when user scrolled to the top of the interface controller and scrolling animation finished
- (void)interfaceOffsetDidScrollToBottom WK_AVAILABLE_WATCHOS_ONLY(4.0); // called when user scrolled to the bottom of the interface controller and scrolling animation finished

+ (void)reloadRootPageControllersWithNames:(NSArray<NSString*> *)names contexts:(nullable NSArray *)contexts orientation:(WKPageOrientation)orientation pageIndex:(NSInteger)pageIndex WK_AVAILABLE_WATCHOS_ONLY(4.0);
- (void)becomeCurrentPage;

- (void)presentControllerWithName:(NSString *)name context:(nullable id)context; // modal presentation
- (void)presentControllerWithNames:(NSArray<NSString*> *)names contexts:(nullable NSArray *)contexts; // modal presentation of paged controllers. contexts matched to controllers
- (void)dismissController;

- (void)presentTextInputControllerWithSuggestions:(nullable NSArray<NSString*> *)suggestions allowedInputMode:(WKTextInputMode)inputMode completion:(void(^)(NSArray * __nullable results))completion; // results is nil if cancelled
- (void)presentTextInputControllerWithSuggestionsForLanguage:(NSArray * __nullable (^ __nullable)(NSString *inputLanguage))suggestionsHandler allowedInputMode:(WKTextInputMode)inputMode completion:(void(^)(NSArray * __nullable results))completion; // will never go straight to dictation because allows for switching input language
- (void)dismissTextInputController;

WKI_EXTERN NSString *const UIUserNotificationActionResponseTypedTextKey WK_DEPRECATED_WATCHOS(2.0, 3.0, "use UNUserNotificationCenterDelegate's userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:");

WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsAutoplayKey WK_AVAILABLE_WATCHOS_ONLY(2.0);      // NSNumber containing BOOL
WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsStartTimeKey WK_AVAILABLE_WATCHOS_ONLY(2.0);     // NSNumber containing NSTimeInterval
WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsVideoGravityKey WK_AVAILABLE_WATCHOS_ONLY(2.0);  // NSNumber containing WKVideoGravity
WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsLoopsKey WK_AVAILABLE_WATCHOS_ONLY(2.0);         // NSNumber containing BOOL

- (void)presentMediaPlayerControllerWithURL:(NSURL *)URL options:(nullable NSDictionary *)options completion:(void(^)(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * __nullable error))completion WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)dismissMediaPlayerController WK_AVAILABLE_WATCHOS_ONLY(2.0);

WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsActionTitleKey WK_AVAILABLE_WATCHOS_ONLY(2.0);           // NSString (default is "Save")
WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsAlwaysShowActionTitleKey WK_AVAILABLE_WATCHOS_ONLY(2.0); // NSNumber containing BOOL (default is NO)
WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsAutorecordKey WK_AVAILABLE_WATCHOS_ONLY(2.0);            // NSNumber containing BOOL (default is YES)
WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsMaximumDurationKey WK_AVAILABLE_WATCHOS_ONLY(2.0);       // NSNumber containing NSTimeInterval

- (void)presentAudioRecorderControllerWithOutputURL:(NSURL *)URL preset:(WKAudioRecorderPreset)preset options:(nullable NSDictionary *)options completion:(void (^)(BOOL didSave, NSError * __nullable error))completion WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)dismissAudioRecorderController WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (nullable id)contextForSegueWithIdentifier:(NSString *)segueIdentifier;
- (nullable NSArray *)contextsForSegueWithIdentifier:(NSString *)segueIdentifier;
- (nullable id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex;
- (nullable NSArray *)contextsForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex;

- (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)presentAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(WKAlertControllerStyle)preferredStyle actions:(NSArray <WKAlertAction *>*)actions WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)presentAddPassesControllerWithPasses:(NSArray <PKPass *> *)passes completion:(void(^)(void))completion WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)dismissAddPassesController WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)addMenuItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action;           // all parameters must be non-nil
- (void)addMenuItemWithImageNamed:(NSString *)imageName title:(NSString *)title action:(SEL)action;
- (void)addMenuItemWithItemIcon:(WKMenuItemIcon)itemIcon title:(NSString *)title action:(SEL)action;
- (void)clearAllMenuItems;

- (void)updateUserActivity:(NSUserActivity *)userActivity WK_AVAILABLE_WATCHOS_ONLY(5.0);
- (void)invalidateUserActivity;

- (void)beginGlanceUpdates WK_DEPRECATED_WATCHOS(2.0, 4.0, "Glances are no longer supported");
- (void)endGlanceUpdates WK_DEPRECATED_WATCHOS(2.0, 4.0, "Glances are no longer supported");

// deprecated
- (void)updateUserActivity:(NSString *)type userInfo:(nullable NSDictionary *)userInfo webpageURL:(nullable NSURL *)webpageURL WK_DEPRECATED_WATCHOS(2.0, 5.0, "use updateUserActivity:");
+ (void)reloadRootControllersWithNames:(NSArray<NSString*> *)names contexts:(nullable NSArray *)contexts WK_DEPRECATED_WATCHOS(2.0, 4.0, "use reloadRootPageControllersWithNames:contexts:orientation:pageIndex:");
- (void)handleUserActivity:(nullable NSDictionary *)userInfo WK_DEPRECATED_WATCHOS(2.0, 4.0, "use WKExtensionDelegate's handleUserActivity:"); // called on root controller(s) with user info

@end

WK_CLASS_AVAILABLE_IOS(8_2)
@interface WKUserNotificationInterfaceController : WKInterfaceController

- (instancetype)init NS_DESIGNATED_INITIALIZER;

// notificationActions can only be changed once didReceiveNotification: has been called
@property (nonatomic, copy) NSArray<UNNotificationAction *> *notificationActions WK_AVAILABLE_WATCHOS_ONLY(5.0);

- (void)didReceiveNotification:(UNNotification *)notification WK_AVAILABLE_WATCHOS_ONLY(5.0);

// Subclasses can implement to return an array of suggestions to use as text responses to a notification.
- (nonnull NSArray<NSString *> *)suggestionsForResponseToActionWithIdentifier:(NSString *)identifier forNotification:(UNNotification *)notification inputLanguage:(NSString *)inputLanguage WK_AVAILABLE_WATCHOS_ONLY(3.0);

// Opens the corresponding applicaton and delivers it the default notification action response
- (void)performNotificationDefaultAction WK_AVAILABLE_WATCHOS_ONLY(5.0);

// dismiss the UI from the WKUserNotificationInterfaceController
- (void)performDismissAction WK_AVAILABLE_WATCHOS_ONLY(5.0);

// deprecated
- (void)dismissController WK_DEPRECATED_WATCHOS(2.0, 5.0, "use performDismissAction");
- (void)didReceiveNotification:(UNNotification *)notification withCompletion:(void(^)(WKUserNotificationInterfaceType interface)) completionHandler WK_DEPRECATED_WATCHOS(3.0, 5.0, "use didReceiveNotification:");

@end

NS_ASSUME_NONNULL_END
import WatchKit
import SwiftUI
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {

    override var body: NotificationView {
        return NotificationView()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification) {
        // This method is called when a notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
    }
}
//
//  WKInterfaceController.h
//  WatchKit
//
//  Copyright (c) 2014-2015 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <WatchKit/WKDefines.h>
#import <UIKit/UIGeometry.h>

NS_ASSUME_NONNULL_BEGIN

@class WKAlertAction;
@class WKInterfaceTable;
@class WKInterfacePicker;
@class WKCrownSequencer;
@class WKInterfaceObject;
@class UIImage;
@class UILocalNotification;
@class PKPass;
@class UNNotification;
@class UNNotificationAction;

typedef NS_ENUM(NSInteger, WKUserNotificationInterfaceType)  {
    WKUserNotificationInterfaceTypeDefault,
    WKUserNotificationInterfaceTypeCustom,
} NS_ENUM_AVAILABLE_IOS(8_2);

typedef NS_ENUM(NSInteger, WKMenuItemIcon)  {
    WKMenuItemIconAccept,       // checkmark
    WKMenuItemIconAdd,          // '+'
    WKMenuItemIconBlock,        // circle w/ slash
    WKMenuItemIconDecline,      // 'x'
    WKMenuItemIconInfo,         // 'i'
    WKMenuItemIconMaybe,        // '?'
    WKMenuItemIconMore,         // '...'
    WKMenuItemIconMute,         // speaker w/ slash
    WKMenuItemIconPause,        // pause button
    WKMenuItemIconPlay,         // play button
    WKMenuItemIconRepeat,       // looping arrows
    WKMenuItemIconResume,       // circular arrow
    WKMenuItemIconShare,        // share icon
    WKMenuItemIconShuffle,      // swapped arrows
    WKMenuItemIconSpeaker,      // speaker icon
    WKMenuItemIconTrash,        // trash icon
} NS_ENUM_AVAILABLE_IOS(8_2);

typedef NS_ENUM(NSInteger, WKTextInputMode)  {
    WKTextInputModePlain,        // text (no emoji) from dictation + suggestions
    WKTextInputModeAllowEmoji,         // text plus non-animated emoji from dictation + suggestions
    WKTextInputModeAllowAnimatedEmoji API_DEPRECATED("Animated Emojis are no longer supported. Use WKTextInputModeAllowEmoji instead", watchos(2.0, 6.0))
};

typedef NS_ENUM(NSInteger, WKAlertControllerStyle) {
    WKAlertControllerStyleAlert,
    WKAlertControllerStyleSideBySideButtonsAlert,
    WKAlertControllerStyleActionSheet,
} WK_AVAILABLE_WATCHOS_ONLY(2.0);

typedef NS_ENUM(NSInteger, WKPageOrientation) {
    WKPageOrientationHorizontal,
    WKPageOrientationVertical,
} WK_AVAILABLE_WATCHOS_ONLY(4.0);

typedef NS_ENUM(NSInteger, WKInterfaceScrollPosition) {
    WKInterfaceScrollPositionTop,
    WKInterfaceScrollPositionCenteredVertically,
    WKInterfaceScrollPositionBottom
} WK_AVAILABLE_WATCHOS_ONLY(4.0);


typedef NS_ENUM(NSInteger, WKVideoGravity)  {
    WKVideoGravityResizeAspect,
    WKVideoGravityResizeAspectFill,
    WKVideoGravityResize
} WK_AVAILABLE_WATCHOS_ONLY(2.0);

/*
 The following presets can be specified to indicate the desired output sample rate. The resulting bit rate depends on the preset and the audio format. The audio file type is inferred from the output URL extension. The audio format is inferred from the audio file type. Supported file types include .wav, .mp4, and .m4a. When the URL extension is .wav, the audio format is LPCM. It is AAC for all other cases.
 */
typedef NS_ENUM(NSInteger, WKAudioRecorderPreset) {
    WKAudioRecorderPresetNarrowBandSpeech,    // @8kHz, LPCM 128kbps, AAC 24kbps
    WKAudioRecorderPresetWideBandSpeech,    // @16kHz, LPCM 256kbps, AAC 32kbps
    WKAudioRecorderPresetHighQualityAudio    // @44.1kHz, LPCM 705.6kbps, AAC 96kbps
} WK_AVAILABLE_WATCHOS_ONLY(2.0);

WK_CLASS_AVAILABLE_IOS(8_2)
@interface WKInterfaceController : NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (void)awakeWithContext:(nullable id)context;   // context from controller that did push or modal presentation. default does nothing

@property (nonatomic, readonly) CGRect contentFrame;
@property (nonatomic, strong, readonly) WKCrownSequencer *crownSequencer;

@property (nonatomic,readonly) UIEdgeInsets contentSafeAreaInsets WK_AVAILABLE_WATCHOS_ONLY(5.0);
@property (nonatomic,readonly) NSDirectionalEdgeInsets systemMinimumLayoutMargins WK_AVAILABLE_WATCHOS_ONLY(5.0);
@property (nonatomic, getter=isTableScrollingHapticFeedbackEnabled) BOOL tableScrollingHapticFeedbackEnabled WK_AVAILABLE_WATCHOS_ONLY(5.0); // enabled by default

- (void)willActivate;      // Called when watch interface is active and able to be updated. Can be called when interface is not visible.
- (void)didDeactivate;     // Called when watch interface is no longer active and cannot be updated.

- (void)didAppear WK_AVAILABLE_WATCHOS_ONLY(2.0);  // Called when watch interface is visible to user
- (void)willDisappear WK_AVAILABLE_WATCHOS_ONLY(2.0); // Called when watch interface is about to no longer be visible

- (void)pickerDidFocus:(WKInterfacePicker *)picker WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)pickerDidResignFocus:(WKInterfacePicker *)picker WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)pickerDidSettle:(WKInterfacePicker *)picker WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex;  // row selection if controller has WKInterfaceTable property
- (void)handleActionWithIdentifier:(nullable NSString *)identifier forNotification:(UNNotification *)notification WK_AVAILABLE_IOS_ONLY(10.0); // when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty

- (void)setTitle:(nullable NSString *)title;        // title of controller. displayed when controller active

- (void)pushControllerWithName:(NSString *)name context:(nullable id)context;  // context passed to child controller via awakeWithContext:
- (void)popController;
- (void)popToRootController;
- (void)scrollToObject:(WKInterfaceObject *)object atScrollPosition:(WKInterfaceScrollPosition)scrollPosition animated:(BOOL)animated WK_AVAILABLE_WATCHOS_ONLY(4.0);
- (void)interfaceDidScrollToTop WK_AVAILABLE_WATCHOS_ONLY(4.0); // Called when user tapped on status bar for scroll-to-top gesture and scrolling animation finished. May be called immediately if already at top
- (void)interfaceOffsetDidScrollToTop WK_AVAILABLE_WATCHOS_ONLY(4.0); // called when user scrolled to the top of the interface controller and scrolling animation finished
- (void)interfaceOffsetDidScrollToBottom WK_AVAILABLE_WATCHOS_ONLY(4.0); // called when user scrolled to the bottom of the interface controller and scrolling animation finished

+ (void)reloadRootPageControllersWithNames:(NSArray<NSString*> *)names contexts:(nullable NSArray *)contexts orientation:(WKPageOrientation)orientation pageIndex:(NSInteger)pageIndex WK_AVAILABLE_WATCHOS_ONLY(4.0);
- (void)becomeCurrentPage;

- (void)presentControllerWithName:(NSString *)name context:(nullable id)context; // modal presentation
- (void)presentControllerWithNames:(NSArray<NSString*> *)names contexts:(nullable NSArray *)contexts; // modal presentation of paged controllers. contexts matched to controllers
- (void)dismissController;

- (void)presentTextInputControllerWithSuggestions:(nullable NSArray<NSString*> *)suggestions allowedInputMode:(WKTextInputMode)inputMode completion:(void(^)(NSArray * __nullable results))completion; // results is nil if cancelled
- (void)presentTextInputControllerWithSuggestionsForLanguage:(NSArray * __nullable (^ __nullable)(NSString *inputLanguage))suggestionsHandler allowedInputMode:(WKTextInputMode)inputMode completion:(void(^)(NSArray * __nullable results))completion; // will never go straight to dictation because allows for switching input language
- (void)dismissTextInputController;

WKI_EXTERN NSString *const UIUserNotificationActionResponseTypedTextKey WK_DEPRECATED_WATCHOS(2.0, 3.0, "use UNUserNotificationCenterDelegate's userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:");

WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsAutoplayKey WK_AVAILABLE_WATCHOS_ONLY(2.0);      // NSNumber containing BOOL
WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsStartTimeKey WK_AVAILABLE_WATCHOS_ONLY(2.0);     // NSNumber containing NSTimeInterval
WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsVideoGravityKey WK_AVAILABLE_WATCHOS_ONLY(2.0);  // NSNumber containing WKVideoGravity
WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsLoopsKey WK_AVAILABLE_WATCHOS_ONLY(2.0);         // NSNumber containing BOOL

- (void)presentMediaPlayerControllerWithURL:(NSURL *)URL options:(nullable NSDictionary *)options completion:(void(^)(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * __nullable error))completion WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)dismissMediaPlayerController WK_AVAILABLE_WATCHOS_ONLY(2.0);

WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsActionTitleKey WK_AVAILABLE_WATCHOS_ONLY(2.0);           // NSString (default is "Save")
WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsAlwaysShowActionTitleKey WK_AVAILABLE_WATCHOS_ONLY(2.0); // NSNumber containing BOOL (default is NO)
WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsAutorecordKey WK_AVAILABLE_WATCHOS_ONLY(2.0);            // NSNumber containing BOOL (default is YES)
WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsMaximumDurationKey WK_AVAILABLE_WATCHOS_ONLY(2.0);       // NSNumber containing NSTimeInterval

- (void)presentAudioRecorderControllerWithOutputURL:(NSURL *)URL preset:(WKAudioRecorderPreset)preset options:(nullable NSDictionary *)options completion:(void (^)(BOOL didSave, NSError * __nullable error))completion WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)dismissAudioRecorderController WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (nullable id)contextForSegueWithIdentifier:(NSString *)segueIdentifier;
- (nullable NSArray *)contextsForSegueWithIdentifier:(NSString *)segueIdentifier;
- (nullable id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex;
- (nullable NSArray *)contextsForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex;

- (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)presentAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(WKAlertControllerStyle)preferredStyle actions:(NSArray <WKAlertAction *>*)actions WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)presentAddPassesControllerWithPasses:(NSArray <PKPass *> *)passes completion:(void(^)(void))completion WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)dismissAddPassesController WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)addMenuItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action;           // all parameters must be non-nil
- (void)addMenuItemWithImageNamed:(NSString *)imageName title:(NSString *)title action:(SEL)action;
- (void)addMenuItemWithItemIcon:(WKMenuItemIcon)itemIcon title:(NSString *)title action:(SEL)action;
- (void)clearAllMenuItems;

- (void)updateUserActivity:(NSUserActivity *)userActivity WK_AVAILABLE_WATCHOS_ONLY(5.0);
- (void)invalidateUserActivity;

- (void)beginGlanceUpdates WK_DEPRECATED_WATCHOS(2.0, 4.0, "Glances are no longer supported");
- (void)endGlanceUpdates WK_DEPRECATED_WATCHOS(2.0, 4.0, "Glances are no longer supported");

// deprecated
- (void)updateUserActivity:(NSString *)type userInfo:(nullable NSDictionary *)userInfo webpageURL:(nullable NSURL *)webpageURL WK_DEPRECATED_WATCHOS(2.0, 5.0, "use updateUserActivity:");
+ (void)reloadRootControllersWithNames:(NSArray<NSString*> *)names contexts:(nullable NSArray *)contexts WK_DEPRECATED_WATCHOS(2.0, 4.0, "use reloadRootPageControllersWithNames:contexts:orientation:pageIndex:");
- (void)handleUserActivity:(nullable NSDictionary *)userInfo WK_DEPRECATED_WATCHOS(2.0, 4.0, "use WKExtensionDelegate's handleUserActivity:"); // called on root controller(s) with user info

@end

WK_CLASS_AVAILABLE_IOS(8_2)
@interface WKUserNotificationInterfaceController : WKInterfaceController

- (instancetype)init NS_DESIGNATED_INITIALIZER;

// notificationActions can only be changed once didReceiveNotification: has been called
@property (nonatomic, copy) NSArray<UNNotificationAction *> *notificationActions WK_AVAILABLE_WATCHOS_ONLY(5.0);

- (void)didReceiveNotification:(UNNotification *)notification WK_AVAILABLE_WATCHOS_ONLY(5.0);

// Subclasses can implement to return an array of suggestions to use as text responses to a notification.
- (nonnull NSArray<NSString *> *)suggestionsForResponseToActionWithIdentifier:(NSString *)identifier forNotification:(UNNotification *)notification inputLanguage:(NSString *)inputLanguage WK_AVAILABLE_WATCHOS_ONLY(3.0);

// Opens the corresponding applicaton and delivers it the default notification action response
- (void)performNotificationDefaultAction WK_AVAILABLE_WATCHOS_ONLY(5.0);

// dismiss the UI from the WKUserNotificationInterfaceController
- (void)performDismissAction WK_AVAILABLE_WATCHOS_ONLY(5.0);

// deprecated
- (void)dismissController WK_DEPRECATED_WATCHOS(2.0, 5.0, "use performDismissAction");
- (void)didReceiveNotification:(UNNotification *)notification withCompletion:(void(^)(WKUserNotificationInterfaceType interface)) completionHandler WK_DEPRECATED_WATCHOS(3.0, 5.0, "use didReceiveNotification:");

@end

NS_ASSUME_NONNULL_END
<add-aggregation>
    <title><#Unique title#></title>
    <table-ref><#Table this detail presents data from#></table-ref>
            
    <slice-by-hierarchy>
        <slice-by-column><#Column used for filtering at this hierarchy level#></slice-by-column>
    </slice-by-hierarchy>
            
    <hierarchy>
        <level>
            <column><#Column to use for first level of aggregation#></column>
        </level>
    </hierarchy>
            
    <column><#Mnemonic of a column to display#></column>
</add-aggregation>
/* CoreAnimation - CAAnimation.h

   Copyright (c) 2006-2018, Apple Inc.
   All rights reserved. */

#import <QuartzCore/CALayer.h>
#import <Foundation/NSObject.h>

@class NSArray, NSString, CAMediaTimingFunction, CAValueFunction;
@protocol CAAnimationDelegate;

NS_ASSUME_NONNULL_BEGIN

typedef NSString * CAAnimationCalculationMode NS_TYPED_ENUM;
typedef NSString * CAAnimationRotationMode NS_TYPED_ENUM;
typedef NSString * CATransitionType NS_TYPED_ENUM;
typedef NSString * CATransitionSubtype NS_TYPED_ENUM;

/** The base animation class. **/

API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
@interface CAAnimation : NSObject
    <NSSecureCoding, NSCopying, CAMediaTiming, CAAction>
{
@private
  void *_attr;
  uint32_t _flags;
}

/* Creates a new animation object. */

+ (instancetype)animation;

/* Animations implement the same property model as defined by CALayer.
 * See CALayer.h for more details. */

+ (nullable id)defaultValueForKey:(NSString *)key;
- (BOOL)shouldArchiveValueForKey:(NSString *)key;

/* A timing function defining the pacing of the animation. Defaults to
 * nil indicating linear pacing. */

@property(nullable, strong) CAMediaTimingFunction *timingFunction;

/* The delegate of the animation. This object is retained for the
 * lifetime of the animation object. Defaults to nil. See below for the
 * supported delegate methods. */

@property(nullable, strong) id <CAAnimationDelegate> delegate;

/* When true, the animation is removed from the render tree once its
 * active duration has passed. Defaults to YES. */

@property(getter=isRemovedOnCompletion) BOOL removedOnCompletion;

@end

/* Delegate methods for CAAnimation. */

@protocol CAAnimationDelegate <NSObject>
@optional

/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim;

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

@end


/** Subclass for property-based animations. **/

API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
@interface CAPropertyAnimation : CAAnimation

/* Creates a new animation object with its `keyPath' property set to
 * 'path'. */

+ (instancetype)animationWithKeyPath:(nullable NSString *)path;

/* The key-path describing the property to be animated. */

@property(nullable, copy) NSString *keyPath;

/* When true the value specified by the animation will be "added" to
 * the current presentation value of the property to produce the new
 * presentation value. The addition function is type-dependent, e.g.
 * for affine transforms the two matrices are concatenated. Defaults to
 * NO. */

@property(getter=isAdditive) BOOL additive;

/* The `cumulative' property affects how repeating animations produce
 * their result. If true then the current value of the animation is the
 * value at the end of the previous repeat cycle, plus the value of the
 * current repeat cycle. If false, the value is simply the value
 * calculated for the current repeat cycle. Defaults to NO. */

@property(getter=isCumulative) BOOL cumulative;

/* If non-nil a function that is applied to interpolated values
 * before they are set as the new presentation value of the animation's
 * target property. Defaults to nil. */

@property(nullable, strong) CAValueFunction *valueFunction;

@end


/** Subclass for basic (single-keyframe) animations. **/

API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
@interface CABasicAnimation : CAPropertyAnimation

/* The objects defining the property values being interpolated between.
 * All are optional, and no more than two should be non-nil. The object
 * type should match the type of the property being animated (using the
 * standard rules described in CALayer.h). The supported modes of
 * animation are:
 *
 * - both `fromValue' and `toValue' non-nil. Interpolates between
 * `fromValue' and `toValue'.
 *
 * - `fromValue' and `byValue' non-nil. Interpolates between
 * `fromValue' and `fromValue' plus `byValue'.
 *
 * - `byValue' and `toValue' non-nil. Interpolates between `toValue'
 * minus `byValue' and `toValue'.
 *
 * - `fromValue' non-nil. Interpolates between `fromValue' and the
 * current presentation value of the property.
 *
 * - `toValue' non-nil. Interpolates between the layer's current value
 * of the property in the render tree and `toValue'.
 *
 * - `byValue' non-nil. Interpolates between the layer's current value
 * of the property in the render tree and that plus `byValue'. */

@property(nullable, strong) id fromValue;
@property(nullable, strong) id toValue;
@property(nullable, strong) id byValue;

@end


/** General keyframe animation class. **/

API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
@interface CAKeyframeAnimation : CAPropertyAnimation

/* An array of objects providing the value of the animation function for
 * each keyframe. */

@property(nullable, copy) NSArray *values;

/* An optional path object defining the behavior of the animation
 * function. When non-nil overrides the `values' property. Each point
 * in the path except for `moveto' points defines a single keyframe for
 * the purpose of timing and interpolation. Defaults to nil. For
 * constant velocity animation along the path, `calculationMode' should
 * be set to `paced'. Upon assignment the path is copied. */

@property(nullable) CGPathRef path;

/* An optional array of `NSNumber' objects defining the pacing of the
 * animation. Each time corresponds to one value in the `values' array,
 * and defines when the value should be used in the animation function.
 * Each value in the array is a floating point number in the range
 * [0,1]. */

@property(nullable, copy) NSArray<NSNumber *> *keyTimes;

/* An optional array of CAMediaTimingFunction objects. If the `values' array
 * defines n keyframes, there should be n-1 objects in the
 * `timingFunctions' array. Each function describes the pacing of one
 * keyframe to keyframe segment. */

@property(nullable, copy) NSArray<CAMediaTimingFunction *> *timingFunctions;

/* The "calculation mode". Possible values are `discrete', `linear',
 * `paced', `cubic' and `cubicPaced'. Defaults to `linear'. When set to
 * `paced' or `cubicPaced' the `keyTimes' and `timingFunctions'
 * properties of the animation are ignored and calculated implicitly. */

@property(copy) CAAnimationCalculationMode calculationMode;

/* For animations with the cubic calculation modes, these properties
 * provide control over the interpolation scheme. Each keyframe may
 * have a tension, continuity and bias value associated with it, each
 * in the range [-1, 1] (this defines a Kochanek-Bartels spline, see
 * http://en.wikipedia.org/wiki/Kochanek-Bartels_spline).
 *
 * The tension value controls the "tightness" of the curve (positive
 * values are tighter, negative values are rounder). The continuity
 * value controls how segments are joined (positive values give sharp
 * corners, negative values give inverted corners). The bias value
 * defines where the curve occurs (positive values move the curve before
 * the control point, negative values move it after the control point).
 *
 * The first value in each array defines the behavior of the tangent to
 * the first control point, the second value controls the second
 * point's tangents, and so on. Any unspecified values default to zero
 * (giving a Catmull-Rom spline if all are unspecified). */

@property(nullable, copy) NSArray<NSNumber *> *tensionValues;
@property(nullable, copy) NSArray<NSNumber *> *continuityValues;
@property(nullable, copy) NSArray<NSNumber *> *biasValues;

/* Defines whether or objects animating along paths rotate to match the
 * path tangent. Possible values are `auto' and `autoReverse'. Defaults
 * to nil. The effect of setting this property to a non-nil value when
 * no path object is supplied is undefined. `autoReverse' rotates to
 * match the tangent plus 180 degrees. */

@property(nullable, copy) CAAnimationRotationMode rotationMode;

@end

/* `calculationMode' strings. */

CA_EXTERN CAAnimationCalculationMode const kCAAnimationLinear
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CAAnimationCalculationMode const kCAAnimationDiscrete
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CAAnimationCalculationMode const kCAAnimationPaced
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CAAnimationCalculationMode const kCAAnimationCubic
    API_AVAILABLE(macos(10.7), ios(4.0), watchos(2.0), tvos(9.0));
CA_EXTERN CAAnimationCalculationMode const kCAAnimationCubicPaced
    API_AVAILABLE(macos(10.7), ios(4.0), watchos(2.0), tvos(9.0));

/* `rotationMode' strings. */

CA_EXTERN CAAnimationRotationMode const kCAAnimationRotateAuto
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CAAnimationRotationMode const kCAAnimationRotateAutoReverse
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

/** Subclass for mass-spring animations. */

API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0))
@interface CASpringAnimation : CABasicAnimation

/* The mass of the object attached to the end of the spring. Must be greater
   than 0. Defaults to one. */

@property CGFloat mass;

/* The spring stiffness coefficient. Must be greater than 0.
 * Defaults to 100. */

@property CGFloat stiffness;

/* The damping coefficient. Must be greater than or equal to 0.
 * Defaults to 10. */

@property CGFloat damping;

/* The initial velocity of the object attached to the spring. Defaults
 * to zero, which represents an unmoving object. Negative values
 * represent the object moving away from the spring attachment point,
 * positive values represent the object moving towards the spring
 * attachment point. */

@property CGFloat initialVelocity;

/* Returns the estimated duration required for the spring system to be
 * considered at rest. The duration is evaluated for the current animation
 * parameters. */

@property(readonly) CFTimeInterval settlingDuration;

@end

/** Transition animation subclass. **/

API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
@interface CATransition : CAAnimation

/* The name of the transition. Current legal transition types include
 * `fade', `moveIn', `push' and `reveal'. Defaults to `fade'. */

@property(copy) CATransitionType type;

/* An optional subtype for the transition. E.g. used to specify the
 * transition direction for motion-based transitions, in which case
 * the legal values are `fromLeft', `fromRight', `fromTop' and
 * `fromBottom'. */

@property(nullable, copy) CATransitionSubtype subtype;

/* The amount of progress through to the transition at which to begin
 * and end execution. Legal values are numbers in the range [0,1].
 * `endProgress' must be greater than or equal to `startProgress'.
 * Default values are 0 and 1 respectively. */

@property float startProgress;
@property float endProgress;

@end

/* Common transition types. */

CA_EXTERN CATransitionType const kCATransitionFade
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CATransitionType const kCATransitionMoveIn
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CATransitionType const kCATransitionPush
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CATransitionType const kCATransitionReveal
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

/* Common transition subtypes. */

CA_EXTERN CATransitionSubtype const kCATransitionFromRight
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CATransitionSubtype const kCATransitionFromLeft
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CATransitionSubtype const kCATransitionFromTop
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CATransitionSubtype const kCATransitionFromBottom
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));


/** Animation subclass for grouped animations. **/

API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
@interface CAAnimationGroup : CAAnimation

/* An array of CAAnimation objects. Each member of the array will run
 * concurrently in the time space of the parent animation using the
 * normal rules. */

@property(nullable, copy) NSArray<CAAnimation *> *animations;

@end

NS_ASSUME_NONNULL_END
/* CoreImage - CIImageAccumulator.h

   Copyright (c) 2004 Apple, Inc.
   All rights reserved. */

#import <CoreImage/CoreImageDefines.h>
#import <CoreImage/CIImage.h>

NS_ASSUME_NONNULL_BEGIN

NS_CLASS_AVAILABLE(10_4, 9_0)
@interface CIImageAccumulator : NSObject
{
    void *_state;
}

/* Create a new accumulator object.
   For pixel format options see CIImage.h.
   The specified color space is used to render the image.
   If no color space is specified, no color matching is done.
   The return values will be null if the format is unsupported or the extent is too big.
*/
+ (nullable instancetype)imageAccumulatorWithExtent:(CGRect)extent
                                             format:(CIFormat)format;

+ (nullable instancetype)imageAccumulatorWithExtent:(CGRect)extent
                                             format:(CIFormat)format
                                         colorSpace:(CGColorSpaceRef)colorSpace
NS_AVAILABLE(10_7, 9_0);

- (nullable instancetype)initWithExtent:(CGRect)extent
                                 format:(CIFormat)format;

- (nullable instancetype)initWithExtent:(CGRect)extent
                                 format:(CIFormat)format
                             colorSpace:(CGColorSpaceRef)colorSpace
NS_AVAILABLE(10_7, 9_0);

/* Return the extent of the accumulator. */
@property (readonly) CGRect extent;

/* Return the pixel format of the accumulator. */
@property (readonly) CIFormat format;

/* Return an image representing the current contents of the accumulator.
 * Rendering the image after subsequently calling setImage: has
 * undefined behavior. */
- (CIImage *)image;

/* Set the image 'im' as the current contents of the accumulator. */
- (void)setImage:(CIImage *)image;

/* Set the image 'im' as the accumulator's contents. The caller guarantees
 * that the new contents only differ from the old within the specified
 * region. */
- (void)setImage:(CIImage *)image dirtyRect:(CGRect)dirtyRect;

/* Reset the accumulator, discarding any pending updates and current content. */
- (void)clear;

@end

NS_ASSUME_NONNULL_END
//
//  HMAccessoryBrowser.h
//  HomeKit
//
//  Copyright (c) 2013-2015 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HomeKit/HMDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class HMHome;
@class HMAccessory;

@protocol HMAccessoryBrowserDelegate;

/*!
 * @brief This class is used to discover new accessories in the home
 *        that have never been paired with and therefore not part of the home.
 */
HM_EXTERN API_AVAILABLE(ios(8.0)) API_UNAVAILABLE(macos, watchos, tvos)
@interface HMAccessoryBrowser : NSObject

/*!
 * @brief Delegate that receives updates on the state of the accessories discovered.
 */
@property(weak, nonatomic, nullable) id<HMAccessoryBrowserDelegate> delegate;

/*!
 * @brief This is the array of HMAccessory objects that represents new
 *        accessories that were discovered as part of a search session.
 *        This array is not updated when a search session is not in progress.
 */
@property(readonly, copy, nonatomic) NSArray<HMAccessory *> *discoveredAccessories;

/*!
 * @brief Starts searching for accessories that are not associated to any home.
 *
 * @discussion If any accessories are discovered, updates are sent to the delegate.
 *             This will scan for the following types of accessories:
 *                 Accessories supporting HomeKit Wireless Accessory Configuration profile
 *                 Accessories supporting HomeKit Accessory Protocol and are already on
 *                     the same infrastructure IP network
 *                 Accessories supporting HomeKit Accessory Protocol on Bluetooth LE transport
 *             The array of discovered accessories will be updated when this method
 *             is called, so applications should clear and reload any stored copies
 *             of that array or previous new accessory objects.
 *
 */
- (void)startSearchingForNewAccessories;

/*!
 * @brief Stops searching for new accessories.
 *
 * @discussion After this method is called, updates will not be sent to the delegate
 *             if new accessories are found or removed. Scanning may continue for system
 *             reasons or if other delegates are still in active searching sessions.
 *             The contents of the array of discovered accessories will not be updated until
 *             startSearchingForNewAccessories is called.
 */
- (void)stopSearchingForNewAccessories;

@end

/*!
 * @brief This delegate receives updates about new accessories in the home.
 */
HM_EXTERN API_AVAILABLE(ios(8.0)) API_UNAVAILABLE(macos, watchos, tvos)
@protocol HMAccessoryBrowserDelegate <NSObject>

@optional

/*!
 * @brief Informs the delegate about new accessories discovered in the home.
 *
 * @param browser Sender of the message.
 *
 * @param accessory New accessory that was discovered.
 */
- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didFindNewAccessory:(HMAccessory *)accessory;

/*!
 * @brief Informs the delegate about new accessories removed from the home.
 *
 * @param browser Sender of the message.
 *
 * @param accessory Accessory that was previously discovered but are no longer reachable.
 *                 This method is also invoked when an accessory is added to a home.
 */
- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didRemoveNewAccessory:(HMAccessory *)accessory;

@end

NS_ASSUME_NONNULL_END
//
//  SCNNode.h
//  SceneKit
//
//  Copyright © 2012-2019 Apple Inc. All rights reserved.
//

#import <SceneKit/SCNAnimation.h>
#import <SceneKit/SCNBoundingVolume.h>
#import <SceneKit/SCNAction.h>
#import <AvailabilityMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class SCNLight;
@class SCNCamera;
@class SCNGeometry;
@class SCNSkinner;
@class SCNMorpher;
@class SCNConstraint;
@class SCNPhysicsBody;
@class SCNPhysicsField;
@class SCNPhysicsBody;
@class SCNHitTestResult;
@class SCNRenderer;
@protocol SCNNodeRendererDelegate;

/*! @group Rendering arguments
    @discussion These keys are used for the 'semantic' argument of -[SCNProgram setSemantic:forSymbol:options:]
                Transforms are SCNMatrix4 wrapped in NSValues.
 */
SCN_EXPORT NSString * const SCNModelTransform;
SCN_EXPORT NSString * const SCNViewTransform;
SCN_EXPORT NSString * const SCNProjectionTransform;
SCN_EXPORT NSString * const SCNNormalTransform;
SCN_EXPORT NSString * const SCNModelViewTransform;
SCN_EXPORT NSString * const SCNModelViewProjectionTransform;

/*! @enum SCNMovabilityHint
 @abstract The available modes of movability.
 @discussion Movable nodes are not captured when computing light probes.
 */
typedef NS_ENUM(NSInteger, SCNMovabilityHint) {
    SCNMovabilityHintFixed,
    SCNMovabilityHintMovable,
} API_AVAILABLE(macos(10.12), ios(10.0), tvos(10.0));

/*! @enum SCNNodeFocusBehavior
 @abstract Control the focus (UIFocus) behavior.
 */
typedef NS_ENUM(NSInteger, SCNNodeFocusBehavior) {
    SCNNodeFocusBehaviorNone = 0,    // Not focusable and node has no impact on other nodes that have focus interaction enabled.
    SCNNodeFocusBehaviorOccluding,   // Not focusable, but will prevent other focusable nodes that this node visually obscures from being focusable.
    SCNNodeFocusBehaviorFocusable    // Focusable and will also prevent other focusable nodes that this node visually obscures from being focusable.
} API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @class SCNNode
 @abstract SCNNode is the model class for node-tree objects.
 @discussion It encapsulates the position, rotations, and other transforms of a node, which define a coordinate system.
             The coordinate systems of all the sub-nodes are relative to the one of their parent node.
 */
SCN_EXPORT
@interface SCNNode : NSObject <NSCopying, NSSecureCoding, SCNAnimatable, SCNActionable, SCNBoundingVolume>

#pragma mark - Creating a Node

/*!
 @method node
 @abstract Creates and initializes a node instance.
 */
+ (instancetype)node;

/*!
 @method nodeWithGeometry:
 @abstract Creates and initializes a node instance with the specified geometry attached.
 @param geometry The geometry to attach.
 */
+ (SCNNode *)nodeWithGeometry:(nullable SCNGeometry *)geometry;



#pragma mark - Copying the Node

/*!
 @method clone
 @abstract Returns a copy of the receiver. The returned instance is autoreleased.
 @discussion The copy is recursive: every child node will be cloned, too. For a non-recursive copy, use copy instead.
 The copied nodes will share their attached objects (light, geometry, camera, ...) with the original instances;
 if you want, for example, to change the materials of the copy independently of the original object, you'll
 have to copy the geometry of the node separately.
 */
- (instancetype)clone;

/*
 @method flattenedClone
 @abstract Returns a clone of the node containing a geometry that concatenates all the geometries contained in the node hierarchy.
 The returned clone is autoreleased.
 */
- (instancetype)flattenedClone API_AVAILABLE(macos(10.9));



#pragma mark - Managing the Node Attributes

/*!
 @property name
 @abstract Determines the name of the receiver.
 */
@property(nonatomic, copy, nullable) NSString *name;

/*!
 @property light
 @abstract Determines the light attached to the receiver.
 */
@property(nonatomic, retain, nullable) SCNLight *light;

/*!
 @property camera
 @abstract Determines the camera attached to the receiver.
 */

@property(nonatomic, retain, nullable) SCNCamera *camera;

/*!
 @property geometry
 @abstract Returns the geometry attached to the receiver.
 */
@property(nonatomic, retain, nullable) SCNGeometry *geometry;

/*!
 @property skinner
 @abstract Returns the skinner attached to the receiver.
 */
@property(nonatomic, retain, nullable) SCNSkinner *skinner API_AVAILABLE(macos(10.9));

/*!
 @property morpher
 @abstract Returns the morpher attached to the receiver.
 */
@property(nonatomic, retain, nullable) SCNMorpher *morpher API_AVAILABLE(macos(10.9));



#pragma mark - Modifying the Node′s Transform

/*!
 @property transform
 @abstract Determines the receiver's transform. Animatable.
 @discussion The transform is the combination of the position, rotation and scale defined below. So when the transform is set, the receiver's position, rotation and scale are changed to match the new transform.
 */
@property(nonatomic) SCNMatrix4 transform;

/*!
 @property worldTransform
 @abstract Determines the receiver's transform in world space (relative to the scene's root node). Animatable.
 */
@property(nonatomic, readonly) SCNMatrix4 worldTransform;
- (void)setWorldTransform:(SCNMatrix4)worldTransform API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property position
 @abstract Determines the receiver's position. Animatable.
 */
@property(nonatomic) SCNVector3 position;

/*!
 @property worldPosition
 @abstract Determines the receiver's position in world space (relative to the scene's root node).
 */
@property(nonatomic) SCNVector3 worldPosition API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property rotation
 @abstract Determines the receiver's rotation. Animatable.
 @discussion The rotation is axis angle rotation. The three first components are the axis, the fourth one is the rotation (in radian).
 */
@property(nonatomic) SCNVector4 rotation;

/*!
 @property orientation
 @abstract Determines the receiver's orientation as a unit quaternion. Animatable.
 */
@property(nonatomic) SCNQuaternion orientation API_AVAILABLE(macos(10.10));

/*!
 @property worldOrientation
 @abstract Determines the receiver's orientation in world space (relative to the scene's root node). Animatable.
 */
@property(nonatomic) SCNQuaternion worldOrientation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));


/*!
 @property eulerAngles
 @abstract Determines the receiver's euler angles. Animatable.
 @dicussion The order of components in this vector matches the axes of rotation:
               1. Pitch (the x component) is the rotation about the node's x-axis (in radians)
               2. Yaw   (the y component) is the rotation about the node's y-axis (in radians)
               3. Roll  (the z component) is the rotation about the node's z-axis (in radians)
            SceneKit applies these rotations in the reverse order of the components:
               1. first roll
               2. then yaw
               3. then pitch
 */
@property(nonatomic) SCNVector3 eulerAngles API_AVAILABLE(macos(10.10));

/*!
 @property scale
 @abstract Determines the receiver's scale. Animatable.
 */
@property(nonatomic) SCNVector3 scale;

/*!
 @property pivot
 @abstract Determines the receiver's pivot. Animatable.
 */
@property(nonatomic) SCNMatrix4 pivot;

#pragma mark - Modifying the Node′s Visibility

/*!
 @property hidden
 @abstract Determines whether the receiver is displayed. Defaults to NO. Animatable.
 */
@property(nonatomic, getter=isHidden) BOOL hidden;

/*!
 @property opacity
 @abstract Determines the opacity of the receiver. Default is 1. Animatable.
 */
@property(nonatomic) CGFloat opacity;

/*!
 @property renderingOrder
 @abstract Determines the rendering order of the receiver.
 @discussion Nodes with greater rendering orders are rendered last. Defaults to 0.
 */
@property(nonatomic) NSInteger renderingOrder;

/*!
 @property castsShadow
 @abstract Determines if the node is rendered in shadow maps. Defaults to YES.
 */
@property(nonatomic) BOOL castsShadow API_AVAILABLE(macos(10.10));

/*!
 @property movabilityHint
 @abstract Communicates to SceneKit’s rendering system about how you want to move content in your scene; it does not affect your ability to change the node’s position or add animations or physics to the node. Defaults to SCNMovabilityHintFixed.
 */
@property(nonatomic) SCNMovabilityHint movabilityHint API_AVAILABLE(macos(10.12), ios(10.0), tvos(10.0));


#pragma mark - Managing the Node Hierarchy

/*!
 @property parentNode
 @abstract Returns the parent node of the receiver.
 */
@property(nonatomic, readonly, nullable) SCNNode *parentNode;

/*!
 @property childNodes
 @abstract Returns the child node array of the receiver.
 */
@property(nonatomic, readonly) NSArray<SCNNode *> *childNodes;

/*!
 @method addChildNode:
 @abstract Appends the node to the receiver’s childNodes array.
 @param child The node to be added to the receiver’s childNodes array.
 */
- (void)addChildNode:(SCNNode *)child;

/*!
 @method insertChildNode:atIndex:
 @abstract Insert a node in the childNodes array at the specified index.
 @param child The node to insert.
 @param index Index in the childNodes array to insert the node.
 */
- (void)insertChildNode:(SCNNode *)child atIndex:(NSUInteger)index;

/*!
 @method removeFromParentNode
 @abstract Removes the node from the childNodes array of the receiver’s parentNode.
 */
- (void)removeFromParentNode;

/*!
 @method replaceChildNode:with:
 @abstract Remove `child' from the childNode array of the receiver and insert 'child2' if non-nil in its position.
 @discussion If the parentNode of `child' is not the receiver, the behavior is undefined.
 @param oldChild The node to replace in the childNodes array.
 @param newChild The new node that will replace the previous one.
 */
- (void)replaceChildNode:(SCNNode *)oldChild with:(SCNNode *)newChild;



#pragma mark - Searching the Node Hierarchy

/*!
 @method childNodeWithName:recursively:
 @abstract Returns the first node found in the node tree with the specified name.
 @discussion The search uses a pre-order tree traversal.
 @param name The name of the node you are searching for.
 @param recursively Set to YES if you want the search to look through the sub-nodes recursively.
 */
- (nullable SCNNode *)childNodeWithName:(NSString *)name recursively:(BOOL)recursively;

/*!
 @method childNodesPassingTest:
 @abstract Returns the child nodes of the receiver that passes a test in a given Block.
 @discussion The search is recursive and uses a pre-order tree traversal.
 @param predicate The block to apply to child nodes of the receiver. The block takes two arguments: "child" is a child node and "stop" is a reference to a Boolean value. The block can set the value to YES to stop further processing of the node hierarchy. The stop argument is an out-only argument. You should only ever set this Boolean to YES within the Block. The Block returns a Boolean value that indicates whether "child" passed the test.
 */
- (NSArray<SCNNode *> *)childNodesPassingTest:(NS_NOESCAPE BOOL (^)(SCNNode *child, BOOL *stop))predicate;

/*!
 @method enumerateChildNodesUsingBlock:
 @abstract Executes a given block on each child node under the receiver.
 @discussion The search is recursive and uses a pre-order tree traversal.
 @param block The block to apply to child nodes of the receiver. The block takes two arguments: "child" is a child node and "stop" is a reference to a Boolean value. The block can set the value to YES to stop further processing of the node hierarchy. The stop argument is an out-only argument. You should only ever set this Boolean to YES within the Block.
 */
- (void)enumerateChildNodesUsingBlock:(NS_NOESCAPE void (^)(SCNNode *child, BOOL *stop))block API_AVAILABLE(macos(10.10));

/*!
 @method enumerateHierarchyUsingBlock:
 @abstract Executes a given block on the receiver and its child nodes.
 @discussion The search is recursive and uses a pre-order tree traversal.
 @param block The block to apply to the receiver and its child nodes. The block takes two arguments: "node" is a node in the hierarchy of the receiver (including the receiver) and "stop" is a reference to a Boolean value. The block can set the value to YES to stop further processing of the node hierarchy. The stop argument is an out-only argument. You should only ever set this Boolean to YES within the Block.
 */
- (void)enumerateHierarchyUsingBlock:(NS_NOESCAPE void (^)(SCNNode *node, BOOL *stop))block API_AVAILABLE(macos(10.12), ios(10.0), tvos(10.0));


#pragma mark - Converting Between Node Coordinate Systems

/*!
 @method convertPosition:toNode:
 @abstract Converts a position from the receiver’s coordinate system to that of the specified node.
 @param position A position specified in the local coordinate system of the receiver.
 @param node The node into whose coordinate system "position" is to be converted. If "node" is nil, this method instead converts to world coordinates.
 */
- (SCNVector3)convertPosition:(SCNVector3)position toNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.9));

/*!
 @method convertPosition:fromNode:
 @abstract Converts a position from the coordinate system of a given node to that of the receiver.
 @param position A position specified in the local coordinate system of "node".
 @param node The node from whose coordinate system "position" is to be converted. If "node" is nil, this method instead converts from world coordinates.
 */
- (SCNVector3)convertPosition:(SCNVector3)position fromNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.9));


/**
 @abstract Converts a vector from the coordinate system of a given node to that of the receiver.

 @param vector A vector specified in the local coordinate system the receiver.
 @param node The node defining the space from which the vector should be transformed. If "node" is nil, this method instead converts from world coordinates.

 @return vector transformed from receiver local space to node local space.
 */
- (SCNVector3)convertVector:(SCNVector3)vector toNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));


/**
 @abstract Converts a vector from the coordinate system of a given node to that of the receiver.

 @param vector A vector specified in the local coordinate system of "node".
 @param node The node defining the space to which the vector should be transformed to. If "node" is nil, this method instead converts from world coordinates.

 @return vector transformed from node space to reveiver local space.
 */
- (SCNVector3)convertVector:(SCNVector3)vector fromNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));


/*!
 @method convertTransform:toNode:
 @abstract Converts a transform from the receiver’s coordinate system to that of the specified node.
 @param transform A transform specified in the local coordinate system of the receiver.
 @param node The node into whose coordinate system "transform" is to be converted. If "node" is nil, this method instead converts to world coordinates.
 */
- (SCNMatrix4)convertTransform:(SCNMatrix4)transform toNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.9));

/*!
 @method convertTransform:fromNode:
 @abstract Converts a transform from the coordinate system of a given node to that of the receiver.
 @param transform A transform specified in the local coordinate system of "node".
 @param node The node from whose coordinate system "transform" is to be converted. If "node" is nil, this method instead converts from world coordinates.
 */
- (SCNMatrix4)convertTransform:(SCNMatrix4)transform fromNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.9));


#pragma mark - Managing the SCNNode′s physics body

/*!
 @property physicsBody
 @abstract The description of the physics body of the receiver.
 @discussion Default is nil.
 */
@property(nonatomic, retain, nullable) SCNPhysicsBody *physicsBody API_AVAILABLE(macos(10.10));


#pragma mark - Managing the Node′s Physics Field

/*!
 @property physicsField
 @abstract The description of the physics field of the receiver.
 @discussion Default is nil.
 */
@property(nonatomic, retain, nullable) SCNPhysicsField *physicsField API_AVAILABLE(macos(10.10));


#pragma mark - Managing the Node′s Constraints

/*!
 @property constraints
 @abstract An array of SCNConstraint that are applied to the receiver.
 @discussion Adding or removing a constraint can be implicitly animated based on the current transaction.
 */
@property(copy, nullable) NSArray<SCNConstraint *> *constraints API_AVAILABLE(macos(10.9));


#pragma mark - Accessing the Presentation Node

/*!
 @property presentationNode
 @abstract Returns the presentation node.
 @discussion Returns a copy of the node containing all the properties as they were at the start of the current transaction, with any active animations applied.
             This gives a close approximation to the version of the node that is currently displayed.
             The effect of attempting to modify the returned node in any way is undefined. The returned node has no parent and no child nodes.
 */
@property(nonatomic, readonly) SCNNode *presentationNode;


#pragma mark - Pause

/*!
 @property paused
 @abstract Controls whether or not the node's actions and animations are updated or paused. Defaults to NO.
 */
@property(nonatomic, getter=isPaused) BOOL paused API_AVAILABLE(macos(10.10));


#pragma mark - Overriding the Rendering with Custom OpenGL Code

/*!
 @property rendererDelegate
 @abstract Specifies the receiver's renderer delegate object.
 @discussion Setting a renderer delegate prevents the SceneKit renderer from drawing the node and lets you use custom OpenGL code instead.
             The preferred way to customize the rendering is to tweak the material properties of the different materials of the node's geometry. SCNMaterial conforms to the SCNShadable protocol and allows for more advanced rendering using GLSL.
             You would typically use a renderer delegate with a node that has no geometry and only serves as a location in space. An example would be attaching a particle system to that node and render it with custom OpenGL code.
 */
@property(nonatomic, assign, nullable) id <SCNNodeRendererDelegate> rendererDelegate;



#pragma mark - Hit Testing in the Node

/*!
 @method hitTestWithSegmentFromPoint:toPoint:options:
 @abstract Returns an array of SCNHitTestResult for each node in the receiver's sub tree that intersects the specified segment.
 @param pointA The first point of the segment relative to the receiver.
 @param pointB The second point of the segment relative to the receiver.
 @param options Optional parameters (see the "Hit test options" section in SCNSceneRenderer.h for the available options).
 @discussion See SCNSceneRenderer.h for a screen-space hit testing method.
 */
- (NSArray<SCNHitTestResult *> *)hitTestWithSegmentFromPoint:(SCNVector3)pointA toPoint:(SCNVector3)pointB options:(nullable NSDictionary<NSString *, id> *)options API_AVAILABLE(macos(10.9));


#pragma mark - Categories

/*!
 @property categoryBitMask
 @abstract Defines what logical 'categories' the receiver belongs too. Defaults to 1.
 @discussion Categories can be used to
                1. exclude nodes from the influence of a given light (see SCNLight.categoryBitMask)
                2. include/exclude nodes from render passes (see SCNTechnique.h)
                3. specify which nodes to use when hit-testing (see SCNHitTestOptionCategoryBitMask)
 */
@property(nonatomic) NSUInteger categoryBitMask API_AVAILABLE(macos(10.10));

#pragma mark - UIFocus support

/*!
 @property focusBehavior
 @abstract Controls the behavior of the receiver regarding the UIFocus system. Defaults to SCNNodeFocusBehaviorNone.
 */
@property(nonatomic) SCNNodeFocusBehavior focusBehavior API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

@end

@interface SCNNode (Transforms)

/*!
 @property localUp
 @abstract The local unit Y axis (0, 1, 0).
 */
@property(class, readonly, nonatomic) SCNVector3 localUp API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property localRight
 @abstract The local unit X axis (1, 0, 0).
 */
@property(class, readonly, nonatomic) SCNVector3 localRight API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property localFront
 @abstract The local unit -Z axis (0, 0, -1).
 */
@property(class, readonly, nonatomic) SCNVector3 localFront API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property worldUp
 @abstract The local unit Y axis (0, 1, 0) in world space.
 */
@property(readonly, nonatomic) SCNVector3 worldUp API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property worldRight
 @abstract The local unit X axis (1, 0, 0) in world space.
 */
@property(readonly, nonatomic) SCNVector3 worldRight API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property worldFront
 @abstract The local unit -Z axis (0, 0, -1) in world space.
 */
@property(readonly, nonatomic) SCNVector3 worldFront API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/**
 Convenience for calling lookAt:up:localFront: with worldUp set to `self.worldUp`
 and localFront [SCNNode localFront].
 @param worldTarget target position in world space.
 */
- (void)lookAt:(SCNVector3)worldTarget API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/**
 Set the orientation of the node so its front vector is pointing toward a given
 target. Using a reference up vector in world space and a front vector in
 local space.

 @param worldTarget position in world space.
 @param worldUp the up vector in world space.
 @param localFront the front vector in local space.
 */
- (void)lookAt:(SCNVector3)worldTarget up:(SCNVector3)worldUp localFront:(SCNVector3)localFront API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/**
 Translate the current node position along the given vector in local space.

 @param translation the translation in local space.
 */
- (void)localTranslateBy:(SCNVector3)translation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/**
 Apply a the given rotation to the current one.

 @param rotation rotation in local space.
 */
- (void)localRotateBy:(SCNQuaternion)rotation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/**
 Apply a rotation relative to a target point in parent space.

 @param worldRotation rotation to apply in world space.
 @param worldTarget position of the target in world space.
 */
- (void)rotateBy:(SCNQuaternion)worldRotation aroundTarget:(SCNVector3)worldTarget API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

@end

/*!
 @category NSObject (SCNNodeRendererDelegate)
 @abstract The SCNNodeRendererDelegate protocol declares the methods that an instance of SCNNode invokes to let a delegate customize its rendering.
 */
@protocol SCNNodeRendererDelegate <NSObject>
@optional

/*!
 @method renderNode:renderer:arguments:
 @abstract Invoked when a node is rendered.
 @discussion The preferred way to customize the rendering is to tweak the material properties of the different materials of the node's geometry. SCNMaterial conforms to the SCNShadable protocol and allows for more advanced rendering using GLSL.
             You would typically use a renderer delegate with a node that has no geometry and only serves as a location in space. An example would be attaching a particle system to that node and render it with custom OpenGL code.
             Only drawing calls and the means to achieve them are supposed to be performed during the renderer delegate callback, any changes in the model (nodes, geometry...) would involve unexpected results.
 @param node The node to render.
 @param renderer The scene renderer to render into.
 @param arguments A dictionary whose values are SCNMatrix4 matrices wrapped in NSValue objects.
 */
- (void)renderNode:(SCNNode *)node renderer:(SCNRenderer *)renderer arguments:(NSDictionary<NSString *, id> *)arguments;

@end

@interface SCNNode (SIMD)

/*!
 @abstract Determines the receiver's transform. Animatable.
 @discussion The transform is the combination of the position, rotation and scale defined below. So when the transform is set, the receiver's position, rotation and scale are changed to match the new transform.
 */
@property(nonatomic) simd_float4x4 simdTransform API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's position. Animatable.
 */
@property(nonatomic) simd_float3 simdPosition API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's rotation. Animatable.
 @discussion The rotation is axis angle rotation. The three first components are the axis, the fourth one is the rotation (in radian).
 */
@property(nonatomic) simd_float4 simdRotation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's orientation as a unit quaternion. Animatable.
 */
@property(nonatomic) simd_quatf simdOrientation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's euler angles. Animatable.
 @dicussion The order of components in this vector matches the axes of rotation:
 1. Pitch (the x component) is the rotation about the node's x-axis (in radians)
 2. Yaw   (the y component) is the rotation about the node's y-axis (in radians)
 3. Roll  (the z component) is the rotation about the node's z-axis (in radians)
 SceneKit applies these rotations in the reverse order of the components:
 1. first roll
 2. then yaw
 3. then pitch
 */
@property(nonatomic) simd_float3 simdEulerAngles API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's scale. Animatable.
 */
@property(nonatomic) simd_float3 simdScale API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's pivot. Animatable.
 */
@property(nonatomic) simd_float4x4 simdPivot API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's position in world space (relative to the scene's root node).
 */
@property(nonatomic) simd_float3 simdWorldPosition API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's orientation in world space (relative to the scene's root node). Animatable.
 */
@property(nonatomic) simd_quatf simdWorldOrientation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's transform in world space (relative to the scene's root node). Animatable.
 */
@property(nonatomic) simd_float4x4 simdWorldTransform API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

- (simd_float3)simdConvertPosition:(simd_float3)position toNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
- (simd_float3)simdConvertPosition:(simd_float3)position fromNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

- (simd_float3)simdConvertVector:(simd_float3)vector toNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
- (simd_float3)simdConvertVector:(simd_float3)vector fromNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

- (simd_float4x4)simdConvertTransform:(simd_float4x4)transform toNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
- (simd_float4x4)simdConvertTransform:(simd_float4x4)transform fromNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

@property(class, readonly, nonatomic) simd_float3 simdLocalUp API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
@property(class, readonly, nonatomic) simd_float3 simdLocalRight API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
@property(class, readonly, nonatomic) simd_float3 simdLocalFront API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

@property(readonly, nonatomic) simd_float3 simdWorldUp API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
@property(readonly, nonatomic) simd_float3 simdWorldRight API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
@property(readonly, nonatomic) simd_float3 simdWorldFront API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

- (void)simdLookAt:(simd_float3)worldTarget API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
- (void)simdLookAt:(simd_float3)worldTarget up:(simd_float3)worldUp localFront:(simd_float3)localFront API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
- (void)simdLocalTranslateBy:(simd_float3)translation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

- (void)simdLocalRotateBy:(simd_quatf)rotation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
- (void)simdRotateBy:(simd_quatf)worldRotation aroundTarget:(simd_float3)worldTarget API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

@end

NS_ASSUME_NONNULL_END

//  ContentView.swift
//  Watch App WatchKit Extension
//
//  Created by Jake Thomas Waller on 2020-10-18.
//  Copyright © 2020 Jake Thomas Waller. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("JakeWaller.ipa")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
/*    CFPlugIn.h
    Copyright (c) 1999-2019, Apple Inc. and the Swift project authors
 
    Portions Copyright (c) 2014-2019, Apple Inc. and the Swift project authors
    Licensed under Apache License v2.0 with Runtime Library Exception
    See http://swift.org/LICENSE.txt for license information
    See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
*/

#if !defined(__COREFOUNDATION_CFPLUGIN__)
#define __COREFOUNDATION_CFPLUGIN__ 1

#if !defined(COREFOUNDATION_CFPLUGINCOM_SEPARATE)
#define COREFOUNDATION_CFPLUGINCOM_SEPARATE 1
#endif

#include <CoreFoundation/CFBase.h>
#include <CoreFoundation/CFArray.h>
#include <CoreFoundation/CFBundle.h>
#include <CoreFoundation/CFString.h>
#include <CoreFoundation/CFURL.h>
#include <CoreFoundation/CFUUID.h>

CF_IMPLICIT_BRIDGING_ENABLED
CF_EXTERN_C_BEGIN

/* ================ Standard Info.plist keys for plugIns ================ */

CF_EXPORT const CFStringRef kCFPlugInDynamicRegistrationKey;
CF_EXPORT const CFStringRef kCFPlugInDynamicRegisterFunctionKey;
CF_EXPORT const CFStringRef kCFPlugInUnloadFunctionKey;
CF_EXPORT const CFStringRef kCFPlugInFactoriesKey;
CF_EXPORT const CFStringRef kCFPlugInTypesKey;

/* ================= Function prototypes for various callbacks ================= */
/* Function types that plugIn authors can implement for various purposes. */

typedef void (*CFPlugInDynamicRegisterFunction)(CFPlugInRef plugIn);
typedef void (*CFPlugInUnloadFunction)(CFPlugInRef plugIn);
typedef void *(*CFPlugInFactoryFunction)(CFAllocatorRef allocator, CFUUIDRef typeUUID);

/* ================= Creating PlugIns ================= */

CF_EXPORT CFTypeID CFPlugInGetTypeID(void);

CF_EXPORT CFPlugInRef CFPlugInCreate(CFAllocatorRef allocator, CFURLRef plugInURL);
    /* Might return an existing instance with the ref-count bumped. */

CF_EXPORT CFBundleRef CFPlugInGetBundle(CFPlugInRef plugIn);

/* ================= Controlling load on demand ================= */
/* For plugIns. */
/* PlugIns that do static registration are load on demand by default. */
/* PlugIns that do dynamic registration are not load on demand by default. */
/* A dynamic registration function can call CFPlugInSetLoadOnDemand(). */

CF_EXPORT void CFPlugInSetLoadOnDemand(CFPlugInRef plugIn, Boolean flag);

CF_EXPORT Boolean CFPlugInIsLoadOnDemand(CFPlugInRef plugIn);

/* ================= Finding factories and creating instances ================= */
/* For plugIn hosts. */
/* Functions for finding factories to create specific types and actually creating instances of a type. */

/* This function finds all the factories from any plugin for the given type.  Returns an array that the caller must release. */
CF_EXPORT CFArrayRef CFPlugInFindFactoriesForPlugInType(CFUUIDRef typeUUID) CF_RETURNS_RETAINED;


/* This function restricts the result to factories from the given plug-in that can create the given type.  Returns an array that the caller must release. */
CF_EXPORT CFArrayRef CFPlugInFindFactoriesForPlugInTypeInPlugIn(CFUUIDRef typeUUID, CFPlugInRef plugIn) CF_RETURNS_RETAINED;

/* This function returns the IUnknown interface for the new instance. */
CF_EXPORT void *CFPlugInInstanceCreate(CFAllocatorRef allocator, CFUUIDRef factoryUUID, CFUUIDRef typeUUID);

/* ================= Registering factories and types ================= */
/* For plugIn writers who must dynamically register things. */
/* Functions to register factory functions and to associate factories with types. */

CF_EXPORT Boolean CFPlugInRegisterFactoryFunction(CFUUIDRef factoryUUID, CFPlugInFactoryFunction func);

CF_EXPORT Boolean CFPlugInRegisterFactoryFunctionByName(CFUUIDRef factoryUUID, CFPlugInRef plugIn, CFStringRef functionName);

CF_EXPORT Boolean CFPlugInUnregisterFactory(CFUUIDRef factoryUUID);

CF_EXPORT Boolean CFPlugInRegisterPlugInType(CFUUIDRef factoryUUID, CFUUIDRef typeUUID);

CF_EXPORT Boolean CFPlugInUnregisterPlugInType(CFUUIDRef factoryUUID, CFUUIDRef typeUUID);

/* ================= Registering instances ================= */
/* When a new instance of a type is created, the instance is responsible for registering itself with the factory that created it and unregistering when it deallocates. */
/* This means that an instance must keep track of the CFUUIDRef of the factory that created it so it can unregister when it goes away. */

CF_EXPORT void CFPlugInAddInstanceForFactory(CFUUIDRef factoryID);

CF_EXPORT void CFPlugInRemoveInstanceForFactory(CFUUIDRef factoryID);


/* Obsolete API */

typedef struct CF_BRIDGED_TYPE(id) __CFPlugInInstance *CFPlugInInstanceRef;

typedef Boolean (*CFPlugInInstanceGetInterfaceFunction)(CFPlugInInstanceRef instance, CFStringRef interfaceName, void **ftbl);
typedef void (*CFPlugInInstanceDeallocateInstanceDataFunction)(void *instanceData);

CF_EXPORT Boolean CFPlugInInstanceGetInterfaceFunctionTable(CFPlugInInstanceRef instance, CFStringRef interfaceName, void **ftbl);

/* This function returns a retained object on 10.8 or later. */
CF_EXPORT CFStringRef CFPlugInInstanceGetFactoryName(CFPlugInInstanceRef instance) CF_RETURNS_RETAINED;

CF_EXPORT void *CFPlugInInstanceGetInstanceData(CFPlugInInstanceRef instance);

CF_EXPORT CFTypeID CFPlugInInstanceGetTypeID(void);

CF_EXPORT CFPlugInInstanceRef CFPlugInInstanceCreateWithInstanceDataSize(CFAllocatorRef allocator, CFIndex instanceDataSize, CFPlugInInstanceDeallocateInstanceDataFunction deallocateInstanceFunction, CFStringRef factoryName, CFPlugInInstanceGetInterfaceFunction getInterfaceFunction);

CF_EXTERN_C_END
CF_IMPLICIT_BRIDGING_DISABLED

#if !COREFOUNDATION_CFPLUGINCOM_SEPARATE
#include <CoreFoundation/CFPlugInCOM.h>
#endif /* !COREFOUNDATION_CFPLUGINCOM_SEPARATE */

#endif /* ! __COREFOUNDATION_CFPLUGIN__ */

/*
     File:       CFNetwork/CFProxySupport.h
 
     Contains:   Support for computing which proxy applies when
 
     Copyright:  Copyright (c) 2006-2013 Apple Inc. All rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFPROXYSUPPORT__
#define __CFPROXYSUPPORT__

#ifndef __CFNETWORKDEFS__
#include <CFNetwork/CFNetworkDefs.h>
#endif

#ifndef __CFARRAY__
#include <CoreFoundation/CFArray.h>
#endif

#ifndef __CFSTRING__
#include <CoreFoundation/CFString.h>
#endif

#ifndef __CFURL__
#include <CoreFoundation/CFURL.h>
#endif

#ifndef __CFERROR__
#include <CoreFoundation/CFError.h>
#endif

#ifndef __CFRUNLOOP__
#include <CoreFoundation/CFRunLoop.h>
#endif

#ifndef __CFSTREAM__
#include <CoreFoundation/CFStream.h>
#endif


/*
    These APIs return arrays of dictionaries, where each dictionary describes a single proxy.
    The arrays represent the order in which the proxies should be tried - try to download the URL
    using the first entry in the array, and if that fails, try using the second entry, and so on.

    The keys to the proxy dictionaries follow the function declarations; every proxy dictionary
    will have an entry for kCFProxyTypeKey.  If the type is anything except
    kCFProxyTypeAutoConfigurationURL, the dictionary will also have entries for the proxy's host
    and port (under kCFProxyHostNameKey and kCFProxyPortNumberKey respectively).  If the type is
    kCFProxyTypeAutoConfigurationURL, it will have an entry for kCFProxyAutoConfigurationURLKey.
    
    The keys for username and password are optional and will only be present if the username
    or password could be extracted from the information passed in (i.e. either the URL itself
    or the proxy dictionary supplied).  These APIs do not consult any external credential stores
    (such as the Keychain).
*/


#if PRAGMA_ONCE
#pragma once
#endif

CF_EXTERN_C_BEGIN
CF_ASSUME_NONNULL_BEGIN

/*!
    @function CFNetworkCopySystemProxySettings
    @discussion Returns a CFDictionary containing the current system internet proxy settings.
    @result Returns a dictionary containing key-value pairs that represent
        the current internet proxy settings.  See below for definitions of the keys and
        values.
        NULL if no proxy settings have been defined or if an error
        was encountered.
        The caller is responsible for releasing the returned dictionary.
*/
CFN_EXPORT __nullable CFDictionaryRef
CFNetworkCopySystemProxySettings(void) CF_AVAILABLE(10_6, 2_0);

    
/*
 *  CFNetworkCopyProxiesForURL()
 *
 *  Discussion:
 *    Given a URL and a proxy dictionary, determines the ordered list
 *    of proxies that should be used to download the given URL.
 *
 *  Parameters:
 *
 *    url:
 *      The URL to be accessed
 *
 *    proxySettings:
 *      A dictionary describing the available proxy settings; the
 *      dictionary's format should match the dictionary returned
 *      by CFNetworkCopySystemProxySettings described below.
 *
 *  Result:
 *    An array of dictionaries; each dictionary describes a single
 *    proxy.  See the comment at the top of this file for how to
 *    interpret the returned dictionaries.
 *
 */
CFN_EXPORT CFArrayRef
CFNetworkCopyProxiesForURL(CFURLRef url, CFDictionaryRef proxySettings) CF_AVAILABLE(10_5, 2_0);




/*
 *  CFProxyAutoConfigurationResultCallback
 *
 *  Discussion:
 *    Callback function to be called when a PAC file computation
 *    (initiated by either CFNetworkExecuteProxyAutoConfigurationScript
 *    or CFNetworkExecuteProxyAutoConfigurationURL) has completed.
 *
 *  Parameters:
 *
 *    client:
 *      The client reference passed in to
 *      CFNetworkExecuteProxyAutoConfigurationScript or
 *      CFNetworkExecuteProxyAutoConfigurationURL
 *
 *    proxyList:
 *      Upon success, the list of proxies returned by the
 *      autoconfiguration script.  The list has the same format as
 *      returned by CFProxyCopyProxiesForURL, above, except that no
 *      entry may be of type kCFProxyTypeAutoConfigurationURL.  Note
 *      that if the client wishes to keep this list, they must retain
 *      it when they receive this callback.
 *
 *    error:
 *      Upon failure, an error object explaining the failure.
 */
typedef CALLBACK_API_C( void , CFProxyAutoConfigurationResultCallback )(void *client, CFArrayRef proxyList, CFErrorRef __nullable error);

/*
 *  CFNetworkCopyProxiesForAutoConfigurationScript()
 *
 *  Discussion:
 *    Synchronously executes the given proxy autoconfiguration script
 *    and returns a valid proxyList and NULL error upon success or a
 *    NULL proxyList and valid error on failure.
 *
 *  Parameters:
 *
 *    proxyAutoConfigurationScript:
 *      A CFString containing the code of the script to be executed.
 *
 *    targetURL:
 *      The URL that should be input in to the autoconfiguration script.
 *
 *    error:
 *      A return argument that will contain a valid error in case of
 *      failure.
 *
 *  Result:
 *    An array of dictionaries describing the proxies returned by the
 *    script or NULL on failure.
 *
 */
CFN_EXPORT __nullable CFArrayRef
CFNetworkCopyProxiesForAutoConfigurationScript(CFStringRef proxyAutoConfigurationScript, CFURLRef targetURL, CFErrorRef * __nullable error) CF_AVAILABLE(10_5, 2_0);


/*
 *  CFNetworkExecuteProxyAutoConfigurationScript()
 *
 *  Discussion:
 *    Begins the process of executing proxyAutoConfigurationScript to
 *    determine the correct proxy to use to retrieve targetURL.  The
 *    caller should schedule the returned run loop source; when the
 *    results are found, the caller's callback will be called via the
 *    run loop, passing a valid proxyList and NULL error upon success,
 *    or a NULL proxyList and valid error on failure.  The caller
 *    should invalidate the returned run loop source if it wishes to
 *    terminate the request before completion. The returned
 *    RunLoopSource will be removed from all run loops and modes on
 *    which it was scheduled after the callback returns.
 *
 *  Parameters:
 *
 *    proxyAutoConfigurationScript:
 *      A CFString containing the code of the script to be executed.
 *
 *    targetURL:
 *      The URL that should be passed to the autoconfiguration script.
 *
 *    cb:
 *      A client callback to notify the caller of completion.
 *
 *    clientContext:
 *      a stream context containing a client info object and optionally
 *      retain / release callbacks for said info object.
 *
 *  Result:
 *    A CFRunLoopSource which the client can use to schedule execution
 *    of the AutoConfiguration Script.
 *
 */
CFN_EXPORT CFRunLoopSourceRef
CFNetworkExecuteProxyAutoConfigurationScript(
  CFStringRef proxyAutoConfigurationScript,
  CFURLRef targetURL,
  CFProxyAutoConfigurationResultCallback cb,
  CFStreamClientContext * clientContext) CF_AVAILABLE(10_5, 2_0);



/*
 *  CFNetworkExecuteProxyAutoConfigurationURL()
 *
 *  Discussion:
 *    As CFNetworkExecuteProxyAutoConfigurationScript(), above, except
 *    that CFNetworkExecuteProxyAutoConfigurationURL will additionally
 *    download the contents of proxyAutoConfigURL, convert it to a
 *    JavaScript string, and then execute that script.
 *  Ownership for the returned CFRunLoopSourceRef follows the copy rule,
 *  the client is responsible for releasing the object.
 *
 */
CFN_EXPORT CFRunLoopSourceRef
CFNetworkExecuteProxyAutoConfigurationURL(
  CFURLRef proxyAutoConfigURL,
  CFURLRef targetURL,
  CFProxyAutoConfigurationResultCallback cb,
  CFStreamClientContext * clientContext) CF_AVAILABLE(10_5, 2_0);


/*
 *  kCFProxyTypeKey
 *
 *  Discussion:
 *    Key for the type of proxy being represented; value will be one of
 *    the kCFProxyType constants listed below.
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeKey CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyHostNameKey
 *
 *  Discussion:
 *    Key for the proxy's hostname; value is a CFString.  Note that
 *    this may be an IPv4 or IPv6 dotted-IP string.
 *
 */
CFN_EXPORT const CFStringRef kCFProxyHostNameKey CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyPortNumberKey
 *
 *  Discussion:
 *    Key for the proxy's port number; value is a CFNumber specifying
 *    the port on which to contact the proxy
 *
 */
CFN_EXPORT const CFStringRef kCFProxyPortNumberKey CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyAutoConfigurationURLKey
 *
 *  Discussion:
 *    Key for the proxy's PAC file location; this key is only present
 *    if the proxy's type is kCFProxyTypeAutoConfigurationURL.  Value
 *    is a CFURL specifying the location of a proxy auto-configuration
 *    file
 *
 */
CFN_EXPORT const CFStringRef kCFProxyAutoConfigurationURLKey CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyAutoConfigurationJavaScriptKey
 *
 *  Discussion:
 *    Key for the proxy's PAC script
 *    The value is a CFString that contains the full JavaScript soure text for the PAC file.
 *
 */
CFN_EXPORT const CFStringRef kCFProxyAutoConfigurationJavaScriptKey CF_AVAILABLE(10_7, 3_0);


/*
 *  kCFProxyUsernameKey
 *
 *  Discussion:
 *    Key for the username to be used with the proxy; value is a
 *    CFString. Note that this key will only be present if the username
 *    could be extracted from the information passed in.  No external
 *    credential stores (like the Keychain) are consulted.
 *
 */
CFN_EXPORT const CFStringRef kCFProxyUsernameKey CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyPasswordKey
 *
 *  Discussion:
 *    Key for the password to be used with the proxy; value is a
 *    CFString. Note that this key will only be present if the username
 *    could be extracted from the information passed in.  No external
 *    credential stores (like the Keychain) are consulted.
 *
 */
CFN_EXPORT const CFStringRef kCFProxyPasswordKey CF_AVAILABLE(10_5, 2_0);

/*
    Possible values for kCFProxyTypeKey:
    kCFProxyTypeNone - no proxy should be used; contact the origin server directly
    kCFProxyTypeHTTP - the proxy is an HTTP proxy
    kCFProxyTypeHTTPS - the proxy is a tunneling proxy as used for HTTPS
    kCFProxyTypeSOCKS - the proxy is a SOCKS proxy
    kCFProxyTypeFTP - the proxy is an FTP proxy
    kCFProxyTypeAutoConfigurationURL - the proxy is specified by a proxy autoconfiguration (PAC) file
*/

/*
 *  kCFProxyTypeNone
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeNone CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyTypeHTTP
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeHTTP CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyTypeHTTPS
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeHTTPS CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyTypeSOCKS
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeSOCKS CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyTypeFTP
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeFTP CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyTypeAutoConfigurationURL
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeAutoConfigurationURL CF_AVAILABLE(10_5, 2_0);

/*
 *  kCFProxyTypeAutoConfigurationJavaScript
 *
 */
CFN_EXPORT const CFStringRef kCFProxyTypeAutoConfigurationJavaScript CF_AVAILABLE(10_7, 3_0);
    
/*
 *  kCFProxyAutoConfigHTTPResponse
 *
 */
CFN_EXPORT const CFStringRef kCFProxyAutoConfigurationHTTPResponseKey CF_AVAILABLE(10_5, 2_0);
    

#if TARGET_OS_MAC
/*
 *  kCFNetworkProxiesExceptionsList
 *
 *  Discussion:
 *    Key for the list of host name patterns that should bypass the proxy; value is a
 *    CFArray of CFStrings.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesExceptionsList CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesExcludeSimpleHostnames
 *
 *  Discussion:
 *    Key whose value indicates if simple hostnames will be excluded; value is a
 *    CFNumber.  Simple hostnames will be excluded if the key is present and has a
 *    non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesExcludeSimpleHostnames CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesFTPEnable
 *
 *  Discussion:
 *    Key for the enabled status of the ftp proxy; value is a
 *    CFNumber.  The proxy is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesFTPEnable CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesFTPPassive
 *
 *  Discussion:
 *    Key for the state of passive mode for the ftp proxy; value is a
 *    CFNumber.  A value of one indicates that passive mode is enabled, a value
 *    of zero indicates that passive mode is not enabled.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesFTPPassive CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesFTPPort
 *
 *  Discussion:
 *    Key for the port number associated with the ftp proxy; value is a
 *    CFNumber which is the port number.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesFTPPort CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesFTPProxy
 *
 *  Discussion:
 *    Key for the host name associated with the ftp proxy; value is a
 *    CFString which is the proxy host name.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesFTPProxy CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesGopherEnable
 *
 *  Discussion:
 *    Key for the enabled status of the gopher proxy; value is a
 *    CFNumber.  The proxy is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesGopherEnable CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesGopherPort
 *
 *  Discussion:
 *    Key for the port number associated with the gopher proxy; value is a
 *    CFNumber which is the port number.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesGopherPort CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesGopherProxy
 *
 *  Discussion:
 *    Key for the host name associated with the gopher proxy; value is a
 *    CFString which is the proxy host name.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesGopherProxy CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesHTTPEnable
 *
 *  Discussion:
 *    Key for the enabled status of the HTTP proxy; value is a
 *    CFNumber.  The proxy is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesHTTPEnable CF_AVAILABLE(10_6, 2_0);

/*
 *  kCFNetworkProxiesHTTPPort
 *
 *  Discussion:
 *    Key for the port number associated with the HTTP proxy; value is a
 *    CFNumber which is the port number.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesHTTPPort CF_AVAILABLE(10_6, 2_0);

/*
 *  kCFNetworkProxiesHTTPProxy
 *
 *  Discussion:
 *    Key for the host name associated with the HTTP proxy; value is a
 *    CFString which is the proxy host name.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesHTTPProxy CF_AVAILABLE(10_6, 2_0);

/*
 *  kCFNetworkProxiesHTTPSEnable
 *
 *  Discussion:
 *    Key for the enabled status of the HTTPS proxy; value is a
 *    CFNumber.  The proxy is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesHTTPSEnable CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesHTTPSPort
 *
 *  Discussion:
 *    Key for the port number associated with the HTTPS proxy; value is a
 *    CFNumber which is the port number.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesHTTPSPort CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesHTTPSProxy
 *
 *  Discussion:
 *    Key for the host name associated with the HTTPS proxy; value is a
 *    CFString which is the proxy host name.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesHTTPSProxy CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesRTSPEnable
 *
 *  Discussion:
 *    Key for the enabled status of the RTSP proxy; value is a
 *    CFNumber.  The proxy is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesRTSPEnable CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesRTSPPort
 *
 *  Discussion:
 *    Key for the port number associated with the RTSP proxy; value is a
 *    CFNumber which is the port number.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesRTSPPort CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesRTSPProxy
 *
 *  Discussion:
 *    Key for the host name associated with the RTSP proxy; value is a
 *    CFString which is the proxy host name.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesRTSPProxy CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesSOCKSEnable
 *
 *  Discussion:
 *    Key for the enabled status of the SOCKS proxy; value is a
 *    CFNumber.  The proxy is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesSOCKSEnable CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesSOCKSPort
 *
 *  Discussion:
 *    Key for the port number associated with the SOCKS proxy; value is a
 *    CFNumber which is the port number.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesSOCKSPort CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesSOCKSProxy
 *
 *  Discussion:
 *    Key for the host name associated with the SOCKS proxy; value is a
 *    CFString which is the proxy host name.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesSOCKSProxy CF_AVAILABLE(10_6, NA);

/*
 *  kCFNetworkProxiesProxyAutoConfigEnable
 *
 *  Discussion:
 *    Key for the enabled status ProxyAutoConfig (PAC); value is a
 *    CFNumber.  ProxyAutoConfig is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesProxyAutoConfigEnable    CF_AVAILABLE(10_6, 2_0);

/*
 *  kCFNetworkProxiesProxyAutoConfigURLString
 *
 *  Discussion:
 *    Key for the url which indicates the location of the ProxyAutoConfig (PAC) file; value is a
 *    CFString which is url for the PAC file.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesProxyAutoConfigURLString CF_AVAILABLE(10_6, 2_0);

/*
 * kCFNetworkProxiesProxyAutoConfigJavaScript
 *
 * Discussion:
 * Key for the string which is the full JavaScript source of the ProxyAutoConfig (PAC) script;  value is a
 * CFString with is the full text source of the PAC script.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesProxyAutoConfigJavaScript    CF_AVAILABLE(10_7, 3_0);
    
/*
 *  kCFNetworkProxiesProxyAutoDiscoveryEnable
 *
 *  Discussion:
 *    Key for the enabled status of proxy auto discovery; value is a
 *    CFNumber.  Proxy auto discovery is enabled if the key is present and has a non-zero value.
 */
CFN_EXPORT const CFStringRef kCFNetworkProxiesProxyAutoDiscoveryEnable CF_AVAILABLE(10_6, NA);
#endif // TARGET_OS_MAC

CF_ASSUME_NONNULL_END
CF_EXTERN_C_END

#endif /* __CFPROXYSUPPORT__ */

[<#indexSet#> enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger index, BOOL *stop) {
    <#statements#>
}];
//
//  WKInterfaceController.h
//  WatchKit
//
//  Copyright (c) 2014-2015 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <WatchKit/WKDefines.h>
#import <UIKit/UIGeometry.h>

NS_ASSUME_NONNULL_BEGIN

@class WKAlertAction;
@class WKInterfaceTable;
@class WKInterfacePicker;
@class WKCrownSequencer;
@class WKInterfaceObject;
@class UIImage;
@class UILocalNotification;
@class PKPass;
@class UNNotification;
@class UNNotificationAction;

typedef NS_ENUM(NSInteger, WKUserNotificationInterfaceType)  {
    WKUserNotificationInterfaceTypeDefault,
    WKUserNotificationInterfaceTypeCustom,
} NS_ENUM_AVAILABLE_IOS(8_2);

typedef NS_ENUM(NSInteger, WKMenuItemIcon)  {
    WKMenuItemIconAccept,       // checkmark
    WKMenuItemIconAdd,          // '+'
    WKMenuItemIconBlock,        // circle w/ slash
    WKMenuItemIconDecline,      // 'x'
    WKMenuItemIconInfo,         // 'i'
    WKMenuItemIconMaybe,        // '?'
    WKMenuItemIconMore,         // '...'
    WKMenuItemIconMute,         // speaker w/ slash
    WKMenuItemIconPause,        // pause button
    WKMenuItemIconPlay,         // play button
    WKMenuItemIconRepeat,       // looping arrows
    WKMenuItemIconResume,       // circular arrow
    WKMenuItemIconShare,        // share icon
    WKMenuItemIconShuffle,      // swapped arrows
    WKMenuItemIconSpeaker,      // speaker icon
    WKMenuItemIconTrash,        // trash icon
} NS_ENUM_AVAILABLE_IOS(8_2);

typedef NS_ENUM(NSInteger, WKTextInputMode)  {
    WKTextInputModePlain,        // text (no emoji) from dictation + suggestions
    WKTextInputModeAllowEmoji,         // text plus non-animated emoji from dictation + suggestions
    WKTextInputModeAllowAnimatedEmoji API_DEPRECATED("Animated Emojis are no longer supported. Use WKTextInputModeAllowEmoji instead", watchos(2.0, 6.0))
};

typedef NS_ENUM(NSInteger, WKAlertControllerStyle) {
    WKAlertControllerStyleAlert,
    WKAlertControllerStyleSideBySideButtonsAlert,
    WKAlertControllerStyleActionSheet,
} WK_AVAILABLE_WATCHOS_ONLY(2.0);

typedef NS_ENUM(NSInteger, WKPageOrientation) {
    WKPageOrientationHorizontal,
    WKPageOrientationVertical,
} WK_AVAILABLE_WATCHOS_ONLY(4.0);

typedef NS_ENUM(NSInteger, WKInterfaceScrollPosition) {
    WKInterfaceScrollPositionTop,
    WKInterfaceScrollPositionCenteredVertically,
    WKInterfaceScrollPositionBottom
} WK_AVAILABLE_WATCHOS_ONLY(4.0);


typedef NS_ENUM(NSInteger, WKVideoGravity)  {
    WKVideoGravityResizeAspect,
    WKVideoGravityResizeAspectFill,
    WKVideoGravityResize
} WK_AVAILABLE_WATCHOS_ONLY(2.0);

/*
 The following presets can be specified to indicate the desired output sample rate. The resulting bit rate depends on the preset and the audio format. The audio file type is inferred from the output URL extension. The audio format is inferred from the audio file type. Supported file types include .wav, .mp4, and .m4a. When the URL extension is .wav, the audio format is LPCM. It is AAC for all other cases.
 */
typedef NS_ENUM(NSInteger, WKAudioRecorderPreset) {
    WKAudioRecorderPresetNarrowBandSpeech,    // @8kHz, LPCM 128kbps, AAC 24kbps
    WKAudioRecorderPresetWideBandSpeech,    // @16kHz, LPCM 256kbps, AAC 32kbps
    WKAudioRecorderPresetHighQualityAudio    // @44.1kHz, LPCM 705.6kbps, AAC 96kbps
} WK_AVAILABLE_WATCHOS_ONLY(2.0);

WK_CLASS_AVAILABLE_IOS(8_2)
@interface WKInterfaceController : NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (void)awakeWithContext:(nullable id)context;   // context from controller that did push or modal presentation. default does nothing

@property (nonatomic, readonly) CGRect contentFrame;
@property (nonatomic, strong, readonly) WKCrownSequencer *crownSequencer;

@property (nonatomic,readonly) UIEdgeInsets contentSafeAreaInsets WK_AVAILABLE_WATCHOS_ONLY(5.0);
@property (nonatomic,readonly) NSDirectionalEdgeInsets systemMinimumLayoutMargins WK_AVAILABLE_WATCHOS_ONLY(5.0);
@property (nonatomic, getter=isTableScrollingHapticFeedbackEnabled) BOOL tableScrollingHapticFeedbackEnabled WK_AVAILABLE_WATCHOS_ONLY(5.0); // enabled by default

- (void)willActivate;      // Called when watch interface is active and able to be updated. Can be called when interface is not visible.
- (void)didDeactivate;     // Called when watch interface is no longer active and cannot be updated.

- (void)didAppear WK_AVAILABLE_WATCHOS_ONLY(2.0);  // Called when watch interface is visible to user
- (void)willDisappear WK_AVAILABLE_WATCHOS_ONLY(2.0); // Called when watch interface is about to no longer be visible

- (void)pickerDidFocus:(WKInterfacePicker *)picker WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)pickerDidResignFocus:(WKInterfacePicker *)picker WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)pickerDidSettle:(WKInterfacePicker *)picker WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex;  // row selection if controller has WKInterfaceTable property
- (void)handleActionWithIdentifier:(nullable NSString *)identifier forNotification:(UNNotification *)notification WK_AVAILABLE_IOS_ONLY(10.0); // when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty

- (void)setTitle:(nullable NSString *)title;        // title of controller. displayed when controller active

- (void)pushControllerWithName:(NSString *)name context:(nullable id)context;  // context passed to child controller via awakeWithContext:
- (void)popController;
- (void)popToRootController;
- (void)scrollToObject:(WKInterfaceObject *)object atScrollPosition:(WKInterfaceScrollPosition)scrollPosition animated:(BOOL)animated WK_AVAILABLE_WATCHOS_ONLY(4.0);
- (void)interfaceDidScrollToTop WK_AVAILABLE_WATCHOS_ONLY(4.0); // Called when user tapped on status bar for scroll-to-top gesture and scrolling animation finished. May be called immediately if already at top
- (void)interfaceOffsetDidScrollToTop WK_AVAILABLE_WATCHOS_ONLY(4.0); // called when user scrolled to the top of the interface controller and scrolling animation finished
- (void)interfaceOffsetDidScrollToBottom WK_AVAILABLE_WATCHOS_ONLY(4.0); // called when user scrolled to the bottom of the interface controller and scrolling animation finished

+ (void)reloadRootPageControllersWithNames:(NSArray<NSString*> *)names contexts:(nullable NSArray *)contexts orientation:(WKPageOrientation)orientation pageIndex:(NSInteger)pageIndex WK_AVAILABLE_WATCHOS_ONLY(4.0);
- (void)becomeCurrentPage;

- (void)presentControllerWithName:(NSString *)name context:(nullable id)context; // modal presentation
- (void)presentControllerWithNames:(NSArray<NSString*> *)names contexts:(nullable NSArray *)contexts; // modal presentation of paged controllers. contexts matched to controllers
- (void)dismissController;

- (void)presentTextInputControllerWithSuggestions:(nullable NSArray<NSString*> *)suggestions allowedInputMode:(WKTextInputMode)inputMode completion:(void(^)(NSArray * __nullable results))completion; // results is nil if cancelled
- (void)presentTextInputControllerWithSuggestionsForLanguage:(NSArray * __nullable (^ __nullable)(NSString *inputLanguage))suggestionsHandler allowedInputMode:(WKTextInputMode)inputMode completion:(void(^)(NSArray * __nullable results))completion; // will never go straight to dictation because allows for switching input language
- (void)dismissTextInputController;

WKI_EXTERN NSString *const UIUserNotificationActionResponseTypedTextKey WK_DEPRECATED_WATCHOS(2.0, 3.0, "use UNUserNotificationCenterDelegate's userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:");

WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsAutoplayKey WK_AVAILABLE_WATCHOS_ONLY(2.0);      // NSNumber containing BOOL
WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsStartTimeKey WK_AVAILABLE_WATCHOS_ONLY(2.0);     // NSNumber containing NSTimeInterval
WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsVideoGravityKey WK_AVAILABLE_WATCHOS_ONLY(2.0);  // NSNumber containing WKVideoGravity
WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsLoopsKey WK_AVAILABLE_WATCHOS_ONLY(2.0);         // NSNumber containing BOOL

- (void)presentMediaPlayerControllerWithURL:(NSURL *)URL options:(nullable NSDictionary *)options completion:(void(^)(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * __nullable error))completion WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)dismissMediaPlayerController WK_AVAILABLE_WATCHOS_ONLY(2.0);

WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsActionTitleKey WK_AVAILABLE_WATCHOS_ONLY(2.0);           // NSString (default is "Save")
WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsAlwaysShowActionTitleKey WK_AVAILABLE_WATCHOS_ONLY(2.0); // NSNumber containing BOOL (default is NO)
WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsAutorecordKey WK_AVAILABLE_WATCHOS_ONLY(2.0);            // NSNumber containing BOOL (default is YES)
WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsMaximumDurationKey WK_AVAILABLE_WATCHOS_ONLY(2.0);       // NSNumber containing NSTimeInterval

- (void)presentAudioRecorderControllerWithOutputURL:(NSURL *)URL preset:(WKAudioRecorderPreset)preset options:(nullable NSDictionary *)options completion:(void (^)(BOOL didSave, NSError * __nullable error))completion WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)dismissAudioRecorderController WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (nullable id)contextForSegueWithIdentifier:(NSString *)segueIdentifier;
- (nullable NSArray *)contextsForSegueWithIdentifier:(NSString *)segueIdentifier;
- (nullable id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex;
- (nullable NSArray *)contextsForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex;

- (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)presentAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(WKAlertControllerStyle)preferredStyle actions:(NSArray <WKAlertAction *>*)actions WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)presentAddPassesControllerWithPasses:(NSArray <PKPass *> *)passes completion:(void(^)(void))completion WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)dismissAddPassesController WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)addMenuItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action;           // all parameters must be non-nil
- (void)addMenuItemWithImageNamed:(NSString *)imageName title:(NSString *)title action:(SEL)action;
- (void)addMenuItemWithItemIcon:(WKMenuItemIcon)itemIcon title:(NSString *)title action:(SEL)action;
- (void)clearAllMenuItems;

- (void)updateUserActivity:(NSUserActivity *)userActivity WK_AVAILABLE_WATCHOS_ONLY(5.0);
- (void)invalidateUserActivity;

- (void)beginGlanceUpdates WK_DEPRECATED_WATCHOS(2.0, 4.0, "Glances are no longer supported");
- (void)endGlanceUpdates WK_DEPRECATED_WATCHOS(2.0, 4.0, "Glances are no longer supported");

// deprecated
- (void)updateUserActivity:(NSString *)type userInfo:(nullable NSDictionary *)userInfo webpageURL:(nullable NSURL *)webpageURL WK_DEPRECATED_WATCHOS(2.0, 5.0, "use updateUserActivity:");
+ (void)reloadRootControllersWithNames:(NSArray<NSString*> *)names contexts:(nullable NSArray *)contexts WK_DEPRECATED_WATCHOS(2.0, 4.0, "use reloadRootPageControllersWithNames:contexts:orientation:pageIndex:");
- (void)handleUserActivity:(nullable NSDictionary *)userInfo WK_DEPRECATED_WATCHOS(2.0, 4.0, "use WKExtensionDelegate's handleUserActivity:"); // called on root controller(s) with user info

@end

WK_CLASS_AVAILABLE_IOS(8_2)
@interface WKUserNotificationInterfaceController : WKInterfaceController

- (instancetype)init NS_DESIGNATED_INITIALIZER;

// notificationActions can only be changed once didReceiveNotification: has been called
@property (nonatomic, copy) NSArray<UNNotificationAction *> *notificationActions WK_AVAILABLE_WATCHOS_ONLY(5.0);

- (void)didReceiveNotification:(UNNotification *)notification WK_AVAILABLE_WATCHOS_ONLY(5.0);

// Subclasses can implement to return an array of suggestions to use as text responses to a notification.
- (nonnull NSArray<NSString *> *)suggestionsForResponseToActionWithIdentifier:(NSString *)identifier forNotification:(UNNotification *)notification inputLanguage:(NSString *)inputLanguage WK_AVAILABLE_WATCHOS_ONLY(3.0);

// Opens the corresponding applicaton and delivers it the default notification action response
- (void)performNotificationDefaultAction WK_AVAILABLE_WATCHOS_ONLY(5.0);

// dismiss the UI from the WKUserNotificationInterfaceController
- (void)performDismissAction WK_AVAILABLE_WATCHOS_ONLY(5.0);

// deprecated
- (void)dismissController WK_DEPRECATED_WATCHOS(2.0, 5.0, "use performDismissAction");
- (void)didReceiveNotification:(UNNotification *)notification withCompletion:(void(^)(WKUserNotificationInterfaceType interface)) completionHandler WK_DEPRECATED_WATCHOS(3.0, 5.0, "use didReceiveNotification:");

@end

NS_ASSUME_NONNULL_END
import WatchKit
import SwiftUI
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {

    override var body: NotificationView {
        return NotificationView()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification) {
        // This method is called when a notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
    }
}
//
//  WKInterfaceController.h
//  WatchKit
//
//  Copyright (c) 2014-2015 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <WatchKit/WKDefines.h>
#import <UIKit/UIGeometry.h>

NS_ASSUME_NONNULL_BEGIN

@class WKAlertAction;
@class WKInterfaceTable;
@class WKInterfacePicker;
@class WKCrownSequencer;
@class WKInterfaceObject;
@class UIImage;
@class UILocalNotification;
@class PKPass;
@class UNNotification;
@class UNNotificationAction;

typedef NS_ENUM(NSInteger, WKUserNotificationInterfaceType)  {
    WKUserNotificationInterfaceTypeDefault,
    WKUserNotificationInterfaceTypeCustom,
} NS_ENUM_AVAILABLE_IOS(8_2);

typedef NS_ENUM(NSInteger, WKMenuItemIcon)  {
    WKMenuItemIconAccept,       // checkmark
    WKMenuItemIconAdd,          // '+'
    WKMenuItemIconBlock,        // circle w/ slash
    WKMenuItemIconDecline,      // 'x'
    WKMenuItemIconInfo,         // 'i'
    WKMenuItemIconMaybe,        // '?'
    WKMenuItemIconMore,         // '...'
    WKMenuItemIconMute,         // speaker w/ slash
    WKMenuItemIconPause,        // pause button
    WKMenuItemIconPlay,         // play button
    WKMenuItemIconRepeat,       // looping arrows
    WKMenuItemIconResume,       // circular arrow
    WKMenuItemIconShare,        // share icon
    WKMenuItemIconShuffle,      // swapped arrows
    WKMenuItemIconSpeaker,      // speaker icon
    WKMenuItemIconTrash,        // trash icon
} NS_ENUM_AVAILABLE_IOS(8_2);

typedef NS_ENUM(NSInteger, WKTextInputMode)  {
    WKTextInputModePlain,        // text (no emoji) from dictation + suggestions
    WKTextInputModeAllowEmoji,         // text plus non-animated emoji from dictation + suggestions
    WKTextInputModeAllowAnimatedEmoji API_DEPRECATED("Animated Emojis are no longer supported. Use WKTextInputModeAllowEmoji instead", watchos(2.0, 6.0))
};

typedef NS_ENUM(NSInteger, WKAlertControllerStyle) {
    WKAlertControllerStyleAlert,
    WKAlertControllerStyleSideBySideButtonsAlert,
    WKAlertControllerStyleActionSheet,
} WK_AVAILABLE_WATCHOS_ONLY(2.0);

typedef NS_ENUM(NSInteger, WKPageOrientation) {
    WKPageOrientationHorizontal,
    WKPageOrientationVertical,
} WK_AVAILABLE_WATCHOS_ONLY(4.0);

typedef NS_ENUM(NSInteger, WKInterfaceScrollPosition) {
    WKInterfaceScrollPositionTop,
    WKInterfaceScrollPositionCenteredVertically,
    WKInterfaceScrollPositionBottom
} WK_AVAILABLE_WATCHOS_ONLY(4.0);


typedef NS_ENUM(NSInteger, WKVideoGravity)  {
    WKVideoGravityResizeAspect,
    WKVideoGravityResizeAspectFill,
    WKVideoGravityResize
} WK_AVAILABLE_WATCHOS_ONLY(2.0);

/*
 The following presets can be specified to indicate the desired output sample rate. The resulting bit rate depends on the preset and the audio format. The audio file type is inferred from the output URL extension. The audio format is inferred from the audio file type. Supported file types include .wav, .mp4, and .m4a. When the URL extension is .wav, the audio format is LPCM. It is AAC for all other cases.
 */
typedef NS_ENUM(NSInteger, WKAudioRecorderPreset) {
    WKAudioRecorderPresetNarrowBandSpeech,    // @8kHz, LPCM 128kbps, AAC 24kbps
    WKAudioRecorderPresetWideBandSpeech,    // @16kHz, LPCM 256kbps, AAC 32kbps
    WKAudioRecorderPresetHighQualityAudio    // @44.1kHz, LPCM 705.6kbps, AAC 96kbps
} WK_AVAILABLE_WATCHOS_ONLY(2.0);

WK_CLASS_AVAILABLE_IOS(8_2)
@interface WKInterfaceController : NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (void)awakeWithContext:(nullable id)context;   // context from controller that did push or modal presentation. default does nothing

@property (nonatomic, readonly) CGRect contentFrame;
@property (nonatomic, strong, readonly) WKCrownSequencer *crownSequencer;

@property (nonatomic,readonly) UIEdgeInsets contentSafeAreaInsets WK_AVAILABLE_WATCHOS_ONLY(5.0);
@property (nonatomic,readonly) NSDirectionalEdgeInsets systemMinimumLayoutMargins WK_AVAILABLE_WATCHOS_ONLY(5.0);
@property (nonatomic, getter=isTableScrollingHapticFeedbackEnabled) BOOL tableScrollingHapticFeedbackEnabled WK_AVAILABLE_WATCHOS_ONLY(5.0); // enabled by default

- (void)willActivate;      // Called when watch interface is active and able to be updated. Can be called when interface is not visible.
- (void)didDeactivate;     // Called when watch interface is no longer active and cannot be updated.

- (void)didAppear WK_AVAILABLE_WATCHOS_ONLY(2.0);  // Called when watch interface is visible to user
- (void)willDisappear WK_AVAILABLE_WATCHOS_ONLY(2.0); // Called when watch interface is about to no longer be visible

- (void)pickerDidFocus:(WKInterfacePicker *)picker WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)pickerDidResignFocus:(WKInterfacePicker *)picker WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)pickerDidSettle:(WKInterfacePicker *)picker WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex;  // row selection if controller has WKInterfaceTable property
- (void)handleActionWithIdentifier:(nullable NSString *)identifier forNotification:(UNNotification *)notification WK_AVAILABLE_IOS_ONLY(10.0); // when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty

- (void)setTitle:(nullable NSString *)title;        // title of controller. displayed when controller active

- (void)pushControllerWithName:(NSString *)name context:(nullable id)context;  // context passed to child controller via awakeWithContext:
- (void)popController;
- (void)popToRootController;
- (void)scrollToObject:(WKInterfaceObject *)object atScrollPosition:(WKInterfaceScrollPosition)scrollPosition animated:(BOOL)animated WK_AVAILABLE_WATCHOS_ONLY(4.0);
- (void)interfaceDidScrollToTop WK_AVAILABLE_WATCHOS_ONLY(4.0); // Called when user tapped on status bar for scroll-to-top gesture and scrolling animation finished. May be called immediately if already at top
- (void)interfaceOffsetDidScrollToTop WK_AVAILABLE_WATCHOS_ONLY(4.0); // called when user scrolled to the top of the interface controller and scrolling animation finished
- (void)interfaceOffsetDidScrollToBottom WK_AVAILABLE_WATCHOS_ONLY(4.0); // called when user scrolled to the bottom of the interface controller and scrolling animation finished

+ (void)reloadRootPageControllersWithNames:(NSArray<NSString*> *)names contexts:(nullable NSArray *)contexts orientation:(WKPageOrientation)orientation pageIndex:(NSInteger)pageIndex WK_AVAILABLE_WATCHOS_ONLY(4.0);
- (void)becomeCurrentPage;

- (void)presentControllerWithName:(NSString *)name context:(nullable id)context; // modal presentation
- (void)presentControllerWithNames:(NSArray<NSString*> *)names contexts:(nullable NSArray *)contexts; // modal presentation of paged controllers. contexts matched to controllers
- (void)dismissController;

- (void)presentTextInputControllerWithSuggestions:(nullable NSArray<NSString*> *)suggestions allowedInputMode:(WKTextInputMode)inputMode completion:(void(^)(NSArray * __nullable results))completion; // results is nil if cancelled
- (void)presentTextInputControllerWithSuggestionsForLanguage:(NSArray * __nullable (^ __nullable)(NSString *inputLanguage))suggestionsHandler allowedInputMode:(WKTextInputMode)inputMode completion:(void(^)(NSArray * __nullable results))completion; // will never go straight to dictation because allows for switching input language
- (void)dismissTextInputController;

WKI_EXTERN NSString *const UIUserNotificationActionResponseTypedTextKey WK_DEPRECATED_WATCHOS(2.0, 3.0, "use UNUserNotificationCenterDelegate's userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:");

WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsAutoplayKey WK_AVAILABLE_WATCHOS_ONLY(2.0);      // NSNumber containing BOOL
WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsStartTimeKey WK_AVAILABLE_WATCHOS_ONLY(2.0);     // NSNumber containing NSTimeInterval
WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsVideoGravityKey WK_AVAILABLE_WATCHOS_ONLY(2.0);  // NSNumber containing WKVideoGravity
WKI_EXTERN NSString *const WKMediaPlayerControllerOptionsLoopsKey WK_AVAILABLE_WATCHOS_ONLY(2.0);         // NSNumber containing BOOL

- (void)presentMediaPlayerControllerWithURL:(NSURL *)URL options:(nullable NSDictionary *)options completion:(void(^)(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * __nullable error))completion WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)dismissMediaPlayerController WK_AVAILABLE_WATCHOS_ONLY(2.0);

WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsActionTitleKey WK_AVAILABLE_WATCHOS_ONLY(2.0);           // NSString (default is "Save")
WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsAlwaysShowActionTitleKey WK_AVAILABLE_WATCHOS_ONLY(2.0); // NSNumber containing BOOL (default is NO)
WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsAutorecordKey WK_AVAILABLE_WATCHOS_ONLY(2.0);            // NSNumber containing BOOL (default is YES)
WKI_EXTERN NSString *const WKAudioRecorderControllerOptionsMaximumDurationKey WK_AVAILABLE_WATCHOS_ONLY(2.0);       // NSNumber containing NSTimeInterval

- (void)presentAudioRecorderControllerWithOutputURL:(NSURL *)URL preset:(WKAudioRecorderPreset)preset options:(nullable NSDictionary *)options completion:(void (^)(BOOL didSave, NSError * __nullable error))completion WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)dismissAudioRecorderController WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (nullable id)contextForSegueWithIdentifier:(NSString *)segueIdentifier;
- (nullable NSArray *)contextsForSegueWithIdentifier:(NSString *)segueIdentifier;
- (nullable id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex;
- (nullable NSArray *)contextsForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex;

- (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)presentAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(WKAlertControllerStyle)preferredStyle actions:(NSArray <WKAlertAction *>*)actions WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)presentAddPassesControllerWithPasses:(NSArray <PKPass *> *)passes completion:(void(^)(void))completion WK_AVAILABLE_WATCHOS_ONLY(2.0);
- (void)dismissAddPassesController WK_AVAILABLE_WATCHOS_ONLY(2.0);

- (void)addMenuItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action;           // all parameters must be non-nil
- (void)addMenuItemWithImageNamed:(NSString *)imageName title:(NSString *)title action:(SEL)action;
- (void)addMenuItemWithItemIcon:(WKMenuItemIcon)itemIcon title:(NSString *)title action:(SEL)action;
- (void)clearAllMenuItems;

- (void)updateUserActivity:(NSUserActivity *)userActivity WK_AVAILABLE_WATCHOS_ONLY(5.0);
- (void)invalidateUserActivity;

- (void)beginGlanceUpdates WK_DEPRECATED_WATCHOS(2.0, 4.0, "Glances are no longer supported");
- (void)endGlanceUpdates WK_DEPRECATED_WATCHOS(2.0, 4.0, "Glances are no longer supported");

// deprecated
- (void)updateUserActivity:(NSString *)type userInfo:(nullable NSDictionary *)userInfo webpageURL:(nullable NSURL *)webpageURL WK_DEPRECATED_WATCHOS(2.0, 5.0, "use updateUserActivity:");
+ (void)reloadRootControllersWithNames:(NSArray<NSString*> *)names contexts:(nullable NSArray *)contexts WK_DEPRECATED_WATCHOS(2.0, 4.0, "use reloadRootPageControllersWithNames:contexts:orientation:pageIndex:");
- (void)handleUserActivity:(nullable NSDictionary *)userInfo WK_DEPRECATED_WATCHOS(2.0, 4.0, "use WKExtensionDelegate's handleUserActivity:"); // called on root controller(s) with user info

@end

WK_CLASS_AVAILABLE_IOS(8_2)
@interface WKUserNotificationInterfaceController : WKInterfaceController

- (instancetype)init NS_DESIGNATED_INITIALIZER;

// notificationActions can only be changed once didReceiveNotification: has been called
@property (nonatomic, copy) NSArray<UNNotificationAction *> *notificationActions WK_AVAILABLE_WATCHOS_ONLY(5.0);

- (void)didReceiveNotification:(UNNotification *)notification WK_AVAILABLE_WATCHOS_ONLY(5.0);

// Subclasses can implement to return an array of suggestions to use as text responses to a notification.
- (nonnull NSArray<NSString *> *)suggestionsForResponseToActionWithIdentifier:(NSString *)identifier forNotification:(UNNotification *)notification inputLanguage:(NSString *)inputLanguage WK_AVAILABLE_WATCHOS_ONLY(3.0);

// Opens the corresponding applicaton and delivers it the default notification action response
- (void)performNotificationDefaultAction WK_AVAILABLE_WATCHOS_ONLY(5.0);

// dismiss the UI from the WKUserNotificationInterfaceController
- (void)performDismissAction WK_AVAILABLE_WATCHOS_ONLY(5.0);

// deprecated
- (void)dismissController WK_DEPRECATED_WATCHOS(2.0, 5.0, "use performDismissAction");
- (void)didReceiveNotification:(UNNotification *)notification withCompletion:(void(^)(WKUserNotificationInterfaceType interface)) completionHandler WK_DEPRECATED_WATCHOS(3.0, 5.0, "use didReceiveNotification:");

@end

NS_ASSUME_NONNULL_END
<add-aggregation>
    <title><#Unique title#></title>
    <table-ref><#Table this detail presents data from#></table-ref>
            
    <slice-by-hierarchy>
        <slice-by-column><#Column used for filtering at this hierarchy level#></slice-by-column>
    </slice-by-hierarchy>
            
    <hierarchy>
        <level>
            <column><#Column to use for first level of aggregation#></column>
        </level>
    </hierarchy>
            
    <column><#Mnemonic of a column to display#></column>
</add-aggregation>
/* CoreAnimation - CAAnimation.h

   Copyright (c) 2006-2018, Apple Inc.
   All rights reserved. */

#import <QuartzCore/CALayer.h>
#import <Foundation/NSObject.h>

@class NSArray, NSString, CAMediaTimingFunction, CAValueFunction;
@protocol CAAnimationDelegate;

NS_ASSUME_NONNULL_BEGIN

typedef NSString * CAAnimationCalculationMode NS_TYPED_ENUM;
typedef NSString * CAAnimationRotationMode NS_TYPED_ENUM;
typedef NSString * CATransitionType NS_TYPED_ENUM;
typedef NSString * CATransitionSubtype NS_TYPED_ENUM;

/** The base animation class. **/

API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
@interface CAAnimation : NSObject
    <NSSecureCoding, NSCopying, CAMediaTiming, CAAction>
{
@private
  void *_attr;
  uint32_t _flags;
}

/* Creates a new animation object. */

+ (instancetype)animation;

/* Animations implement the same property model as defined by CALayer.
 * See CALayer.h for more details. */

+ (nullable id)defaultValueForKey:(NSString *)key;
- (BOOL)shouldArchiveValueForKey:(NSString *)key;

/* A timing function defining the pacing of the animation. Defaults to
 * nil indicating linear pacing. */

@property(nullable, strong) CAMediaTimingFunction *timingFunction;

/* The delegate of the animation. This object is retained for the
 * lifetime of the animation object. Defaults to nil. See below for the
 * supported delegate methods. */

@property(nullable, strong) id <CAAnimationDelegate> delegate;

/* When true, the animation is removed from the render tree once its
 * active duration has passed. Defaults to YES. */

@property(getter=isRemovedOnCompletion) BOOL removedOnCompletion;

@end

/* Delegate methods for CAAnimation. */

@protocol CAAnimationDelegate <NSObject>
@optional

/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim;

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

@end


/** Subclass for property-based animations. **/

API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
@interface CAPropertyAnimation : CAAnimation

/* Creates a new animation object with its `keyPath' property set to
 * 'path'. */

+ (instancetype)animationWithKeyPath:(nullable NSString *)path;

/* The key-path describing the property to be animated. */

@property(nullable, copy) NSString *keyPath;

/* When true the value specified by the animation will be "added" to
 * the current presentation value of the property to produce the new
 * presentation value. The addition function is type-dependent, e.g.
 * for affine transforms the two matrices are concatenated. Defaults to
 * NO. */

@property(getter=isAdditive) BOOL additive;

/* The `cumulative' property affects how repeating animations produce
 * their result. If true then the current value of the animation is the
 * value at the end of the previous repeat cycle, plus the value of the
 * current repeat cycle. If false, the value is simply the value
 * calculated for the current repeat cycle. Defaults to NO. */

@property(getter=isCumulative) BOOL cumulative;

/* If non-nil a function that is applied to interpolated values
 * before they are set as the new presentation value of the animation's
 * target property. Defaults to nil. */

@property(nullable, strong) CAValueFunction *valueFunction;

@end


/** Subclass for basic (single-keyframe) animations. **/

API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
@interface CABasicAnimation : CAPropertyAnimation

/* The objects defining the property values being interpolated between.
 * All are optional, and no more than two should be non-nil. The object
 * type should match the type of the property being animated (using the
 * standard rules described in CALayer.h). The supported modes of
 * animation are:
 *
 * - both `fromValue' and `toValue' non-nil. Interpolates between
 * `fromValue' and `toValue'.
 *
 * - `fromValue' and `byValue' non-nil. Interpolates between
 * `fromValue' and `fromValue' plus `byValue'.
 *
 * - `byValue' and `toValue' non-nil. Interpolates between `toValue'
 * minus `byValue' and `toValue'.
 *
 * - `fromValue' non-nil. Interpolates between `fromValue' and the
 * current presentation value of the property.
 *
 * - `toValue' non-nil. Interpolates between the layer's current value
 * of the property in the render tree and `toValue'.
 *
 * - `byValue' non-nil. Interpolates between the layer's current value
 * of the property in the render tree and that plus `byValue'. */

@property(nullable, strong) id fromValue;
@property(nullable, strong) id toValue;
@property(nullable, strong) id byValue;

@end


/** General keyframe animation class. **/

API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
@interface CAKeyframeAnimation : CAPropertyAnimation

/* An array of objects providing the value of the animation function for
 * each keyframe. */

@property(nullable, copy) NSArray *values;

/* An optional path object defining the behavior of the animation
 * function. When non-nil overrides the `values' property. Each point
 * in the path except for `moveto' points defines a single keyframe for
 * the purpose of timing and interpolation. Defaults to nil. For
 * constant velocity animation along the path, `calculationMode' should
 * be set to `paced'. Upon assignment the path is copied. */

@property(nullable) CGPathRef path;

/* An optional array of `NSNumber' objects defining the pacing of the
 * animation. Each time corresponds to one value in the `values' array,
 * and defines when the value should be used in the animation function.
 * Each value in the array is a floating point number in the range
 * [0,1]. */

@property(nullable, copy) NSArray<NSNumber *> *keyTimes;

/* An optional array of CAMediaTimingFunction objects. If the `values' array
 * defines n keyframes, there should be n-1 objects in the
 * `timingFunctions' array. Each function describes the pacing of one
 * keyframe to keyframe segment. */

@property(nullable, copy) NSArray<CAMediaTimingFunction *> *timingFunctions;

/* The "calculation mode". Possible values are `discrete', `linear',
 * `paced', `cubic' and `cubicPaced'. Defaults to `linear'. When set to
 * `paced' or `cubicPaced' the `keyTimes' and `timingFunctions'
 * properties of the animation are ignored and calculated implicitly. */

@property(copy) CAAnimationCalculationMode calculationMode;

/* For animations with the cubic calculation modes, these properties
 * provide control over the interpolation scheme. Each keyframe may
 * have a tension, continuity and bias value associated with it, each
 * in the range [-1, 1] (this defines a Kochanek-Bartels spline, see
 * http://en.wikipedia.org/wiki/Kochanek-Bartels_spline).
 *
 * The tension value controls the "tightness" of the curve (positive
 * values are tighter, negative values are rounder). The continuity
 * value controls how segments are joined (positive values give sharp
 * corners, negative values give inverted corners). The bias value
 * defines where the curve occurs (positive values move the curve before
 * the control point, negative values move it after the control point).
 *
 * The first value in each array defines the behavior of the tangent to
 * the first control point, the second value controls the second
 * point's tangents, and so on. Any unspecified values default to zero
 * (giving a Catmull-Rom spline if all are unspecified). */

@property(nullable, copy) NSArray<NSNumber *> *tensionValues;
@property(nullable, copy) NSArray<NSNumber *> *continuityValues;
@property(nullable, copy) NSArray<NSNumber *> *biasValues;

/* Defines whether or objects animating along paths rotate to match the
 * path tangent. Possible values are `auto' and `autoReverse'. Defaults
 * to nil. The effect of setting this property to a non-nil value when
 * no path object is supplied is undefined. `autoReverse' rotates to
 * match the tangent plus 180 degrees. */

@property(nullable, copy) CAAnimationRotationMode rotationMode;

@end

/* `calculationMode' strings. */

CA_EXTERN CAAnimationCalculationMode const kCAAnimationLinear
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CAAnimationCalculationMode const kCAAnimationDiscrete
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CAAnimationCalculationMode const kCAAnimationPaced
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CAAnimationCalculationMode const kCAAnimationCubic
    API_AVAILABLE(macos(10.7), ios(4.0), watchos(2.0), tvos(9.0));
CA_EXTERN CAAnimationCalculationMode const kCAAnimationCubicPaced
    API_AVAILABLE(macos(10.7), ios(4.0), watchos(2.0), tvos(9.0));

/* `rotationMode' strings. */

CA_EXTERN CAAnimationRotationMode const kCAAnimationRotateAuto
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CAAnimationRotationMode const kCAAnimationRotateAutoReverse
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

/** Subclass for mass-spring animations. */

API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0))
@interface CASpringAnimation : CABasicAnimation

/* The mass of the object attached to the end of the spring. Must be greater
   than 0. Defaults to one. */

@property CGFloat mass;

/* The spring stiffness coefficient. Must be greater than 0.
 * Defaults to 100. */

@property CGFloat stiffness;

/* The damping coefficient. Must be greater than or equal to 0.
 * Defaults to 10. */

@property CGFloat damping;

/* The initial velocity of the object attached to the spring. Defaults
 * to zero, which represents an unmoving object. Negative values
 * represent the object moving away from the spring attachment point,
 * positive values represent the object moving towards the spring
 * attachment point. */

@property CGFloat initialVelocity;

/* Returns the estimated duration required for the spring system to be
 * considered at rest. The duration is evaluated for the current animation
 * parameters. */

@property(readonly) CFTimeInterval settlingDuration;

@end

/** Transition animation subclass. **/

API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
@interface CATransition : CAAnimation

/* The name of the transition. Current legal transition types include
 * `fade', `moveIn', `push' and `reveal'. Defaults to `fade'. */

@property(copy) CATransitionType type;

/* An optional subtype for the transition. E.g. used to specify the
 * transition direction for motion-based transitions, in which case
 * the legal values are `fromLeft', `fromRight', `fromTop' and
 * `fromBottom'. */

@property(nullable, copy) CATransitionSubtype subtype;

/* The amount of progress through to the transition at which to begin
 * and end execution. Legal values are numbers in the range [0,1].
 * `endProgress' must be greater than or equal to `startProgress'.
 * Default values are 0 and 1 respectively. */

@property float startProgress;
@property float endProgress;

@end

/* Common transition types. */

CA_EXTERN CATransitionType const kCATransitionFade
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CATransitionType const kCATransitionMoveIn
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CATransitionType const kCATransitionPush
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CATransitionType const kCATransitionReveal
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

/* Common transition subtypes. */

CA_EXTERN CATransitionSubtype const kCATransitionFromRight
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CATransitionSubtype const kCATransitionFromLeft
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CATransitionSubtype const kCATransitionFromTop
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));
CA_EXTERN CATransitionSubtype const kCATransitionFromBottom
    API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));


/** Animation subclass for grouped animations. **/

API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
@interface CAAnimationGroup : CAAnimation

/* An array of CAAnimation objects. Each member of the array will run
 * concurrently in the time space of the parent animation using the
 * normal rules. */

@property(nullable, copy) NSArray<CAAnimation *> *animations;

@end

NS_ASSUME_NONNULL_END
/* CoreImage - CIImageAccumulator.h

   Copyright (c) 2004 Apple, Inc.
   All rights reserved. */

#import <CoreImage/CoreImageDefines.h>
#import <CoreImage/CIImage.h>

NS_ASSUME_NONNULL_BEGIN

NS_CLASS_AVAILABLE(10_4, 9_0)
@interface CIImageAccumulator : NSObject
{
    void *_state;
}

/* Create a new accumulator object.
   For pixel format options see CIImage.h.
   The specified color space is used to render the image.
   If no color space is specified, no color matching is done.
   The return values will be null if the format is unsupported or the extent is too big.
*/
+ (nullable instancetype)imageAccumulatorWithExtent:(CGRect)extent
                                             format:(CIFormat)format;

+ (nullable instancetype)imageAccumulatorWithExtent:(CGRect)extent
                                             format:(CIFormat)format
                                         colorSpace:(CGColorSpaceRef)colorSpace
NS_AVAILABLE(10_7, 9_0);

- (nullable instancetype)initWithExtent:(CGRect)extent
                                 format:(CIFormat)format;

- (nullable instancetype)initWithExtent:(CGRect)extent
                                 format:(CIFormat)format
                             colorSpace:(CGColorSpaceRef)colorSpace
NS_AVAILABLE(10_7, 9_0);

/* Return the extent of the accumulator. */
@property (readonly) CGRect extent;

/* Return the pixel format of the accumulator. */
@property (readonly) CIFormat format;

/* Return an image representing the current contents of the accumulator.
 * Rendering the image after subsequently calling setImage: has
 * undefined behavior. */
- (CIImage *)image;

/* Set the image 'im' as the current contents of the accumulator. */
- (void)setImage:(CIImage *)image;

/* Set the image 'im' as the accumulator's contents. The caller guarantees
 * that the new contents only differ from the old within the specified
 * region. */
- (void)setImage:(CIImage *)image dirtyRect:(CGRect)dirtyRect;

/* Reset the accumulator, discarding any pending updates and current content. */
- (void)clear;

@end

NS_ASSUME_NONNULL_END
//
//  HMAccessoryBrowser.h
//  HomeKit
//
//  Copyright (c) 2013-2015 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HomeKit/HMDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class HMHome;
@class HMAccessory;

@protocol HMAccessoryBrowserDelegate;

/*!
 * @brief This class is used to discover new accessories in the home
 *        that have never been paired with and therefore not part of the home.
 */
HM_EXTERN API_AVAILABLE(ios(8.0)) API_UNAVAILABLE(macos, watchos, tvos)
@interface HMAccessoryBrowser : NSObject

/*!
 * @brief Delegate that receives updates on the state of the accessories discovered.
 */
@property(weak, nonatomic, nullable) id<HMAccessoryBrowserDelegate> delegate;

/*!
 * @brief This is the array of HMAccessory objects that represents new
 *        accessories that were discovered as part of a search session.
 *        This array is not updated when a search session is not in progress.
 */
@property(readonly, copy, nonatomic) NSArray<HMAccessory *> *discoveredAccessories;

/*!
 * @brief Starts searching for accessories that are not associated to any home.
 *
 * @discussion If any accessories are discovered, updates are sent to the delegate.
 *             This will scan for the following types of accessories:
 *                 Accessories supporting HomeKit Wireless Accessory Configuration profile
 *                 Accessories supporting HomeKit Accessory Protocol and are already on
 *                     the same infrastructure IP network
 *                 Accessories supporting HomeKit Accessory Protocol on Bluetooth LE transport
 *             The array of discovered accessories will be updated when this method
 *             is called, so applications should clear and reload any stored copies
 *             of that array or previous new accessory objects.
 *
 */
- (void)startSearchingForNewAccessories;

/*!
 * @brief Stops searching for new accessories.
 *
 * @discussion After this method is called, updates will not be sent to the delegate
 *             if new accessories are found or removed. Scanning may continue for system
 *             reasons or if other delegates are still in active searching sessions.
 *             The contents of the array of discovered accessories will not be updated until
 *             startSearchingForNewAccessories is called.
 */
- (void)stopSearchingForNewAccessories;

@end

/*!
 * @brief This delegate receives updates about new accessories in the home.
 */
HM_EXTERN API_AVAILABLE(ios(8.0)) API_UNAVAILABLE(macos, watchos, tvos)
@protocol HMAccessoryBrowserDelegate <NSObject>

@optional

/*!
 * @brief Informs the delegate about new accessories discovered in the home.
 *
 * @param browser Sender of the message.
 *
 * @param accessory New accessory that was discovered.
 */
- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didFindNewAccessory:(HMAccessory *)accessory;

/*!
 * @brief Informs the delegate about new accessories removed from the home.
 *
 * @param browser Sender of the message.
 *
 * @param accessory Accessory that was previously discovered but are no longer reachable.
 *                 This method is also invoked when an accessory is added to a home.
 */
- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didRemoveNewAccessory:(HMAccessory *)accessory;

@end

NS_ASSUME_NONNULL_END
//
//  SCNNode.h
//  SceneKit
//
//  Copyright © 2012-2019 Apple Inc. All rights reserved.
//

#import <SceneKit/SCNAnimation.h>
#import <SceneKit/SCNBoundingVolume.h>
#import <SceneKit/SCNAction.h>
#import <AvailabilityMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class SCNLight;
@class SCNCamera;
@class SCNGeometry;
@class SCNSkinner;
@class SCNMorpher;
@class SCNConstraint;
@class SCNPhysicsBody;
@class SCNPhysicsField;
@class SCNPhysicsBody;
@class SCNHitTestResult;
@class SCNRenderer;
@protocol SCNNodeRendererDelegate;

/*! @group Rendering arguments
    @discussion These keys are used for the 'semantic' argument of -[SCNProgram setSemantic:forSymbol:options:]
                Transforms are SCNMatrix4 wrapped in NSValues.
 */
SCN_EXPORT NSString * const SCNModelTransform;
SCN_EXPORT NSString * const SCNViewTransform;
SCN_EXPORT NSString * const SCNProjectionTransform;
SCN_EXPORT NSString * const SCNNormalTransform;
SCN_EXPORT NSString * const SCNModelViewTransform;
SCN_EXPORT NSString * const SCNModelViewProjectionTransform;

/*! @enum SCNMovabilityHint
 @abstract The available modes of movability.
 @discussion Movable nodes are not captured when computing light probes.
 */
typedef NS_ENUM(NSInteger, SCNMovabilityHint) {
    SCNMovabilityHintFixed,
    SCNMovabilityHintMovable,
} API_AVAILABLE(macos(10.12), ios(10.0), tvos(10.0));

/*! @enum SCNNodeFocusBehavior
 @abstract Control the focus (UIFocus) behavior.
 */
typedef NS_ENUM(NSInteger, SCNNodeFocusBehavior) {
    SCNNodeFocusBehaviorNone = 0,    // Not focusable and node has no impact on other nodes that have focus interaction enabled.
    SCNNodeFocusBehaviorOccluding,   // Not focusable, but will prevent other focusable nodes that this node visually obscures from being focusable.
    SCNNodeFocusBehaviorFocusable    // Focusable and will also prevent other focusable nodes that this node visually obscures from being focusable.
} API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @class SCNNode
 @abstract SCNNode is the model class for node-tree objects.
 @discussion It encapsulates the position, rotations, and other transforms of a node, which define a coordinate system.
             The coordinate systems of all the sub-nodes are relative to the one of their parent node.
 */
SCN_EXPORT
@interface SCNNode : NSObject <NSCopying, NSSecureCoding, SCNAnimatable, SCNActionable, SCNBoundingVolume>

#pragma mark - Creating a Node

/*!
 @method node
 @abstract Creates and initializes a node instance.
 */
+ (instancetype)node;

/*!
 @method nodeWithGeometry:
 @abstract Creates and initializes a node instance with the specified geometry attached.
 @param geometry The geometry to attach.
 */
+ (SCNNode *)nodeWithGeometry:(nullable SCNGeometry *)geometry;



#pragma mark - Copying the Node

/*!
 @method clone
 @abstract Returns a copy of the receiver. The returned instance is autoreleased.
 @discussion The copy is recursive: every child node will be cloned, too. For a non-recursive copy, use copy instead.
 The copied nodes will share their attached objects (light, geometry, camera, ...) with the original instances;
 if you want, for example, to change the materials of the copy independently of the original object, you'll
 have to copy the geometry of the node separately.
 */
- (instancetype)clone;

/*
 @method flattenedClone
 @abstract Returns a clone of the node containing a geometry that concatenates all the geometries contained in the node hierarchy.
 The returned clone is autoreleased.
 */
- (instancetype)flattenedClone API_AVAILABLE(macos(10.9));



#pragma mark - Managing the Node Attributes

/*!
 @property name
 @abstract Determines the name of the receiver.
 */
@property(nonatomic, copy, nullable) NSString *name;

/*!
 @property light
 @abstract Determines the light attached to the receiver.
 */
@property(nonatomic, retain, nullable) SCNLight *light;

/*!
 @property camera
 @abstract Determines the camera attached to the receiver.
 */

@property(nonatomic, retain, nullable) SCNCamera *camera;

/*!
 @property geometry
 @abstract Returns the geometry attached to the receiver.
 */
@property(nonatomic, retain, nullable) SCNGeometry *geometry;

/*!
 @property skinner
 @abstract Returns the skinner attached to the receiver.
 */
@property(nonatomic, retain, nullable) SCNSkinner *skinner API_AVAILABLE(macos(10.9));

/*!
 @property morpher
 @abstract Returns the morpher attached to the receiver.
 */
@property(nonatomic, retain, nullable) SCNMorpher *morpher API_AVAILABLE(macos(10.9));



#pragma mark - Modifying the Node′s Transform

/*!
 @property transform
 @abstract Determines the receiver's transform. Animatable.
 @discussion The transform is the combination of the position, rotation and scale defined below. So when the transform is set, the receiver's position, rotation and scale are changed to match the new transform.
 */
@property(nonatomic) SCNMatrix4 transform;

/*!
 @property worldTransform
 @abstract Determines the receiver's transform in world space (relative to the scene's root node). Animatable.
 */
@property(nonatomic, readonly) SCNMatrix4 worldTransform;
- (void)setWorldTransform:(SCNMatrix4)worldTransform API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property position
 @abstract Determines the receiver's position. Animatable.
 */
@property(nonatomic) SCNVector3 position;

/*!
 @property worldPosition
 @abstract Determines the receiver's position in world space (relative to the scene's root node).
 */
@property(nonatomic) SCNVector3 worldPosition API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property rotation
 @abstract Determines the receiver's rotation. Animatable.
 @discussion The rotation is axis angle rotation. The three first components are the axis, the fourth one is the rotation (in radian).
 */
@property(nonatomic) SCNVector4 rotation;

/*!
 @property orientation
 @abstract Determines the receiver's orientation as a unit quaternion. Animatable.
 */
@property(nonatomic) SCNQuaternion orientation API_AVAILABLE(macos(10.10));

/*!
 @property worldOrientation
 @abstract Determines the receiver's orientation in world space (relative to the scene's root node). Animatable.
 */
@property(nonatomic) SCNQuaternion worldOrientation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));


/*!
 @property eulerAngles
 @abstract Determines the receiver's euler angles. Animatable.
 @dicussion The order of components in this vector matches the axes of rotation:
               1. Pitch (the x component) is the rotation about the node's x-axis (in radians)
               2. Yaw   (the y component) is the rotation about the node's y-axis (in radians)
               3. Roll  (the z component) is the rotation about the node's z-axis (in radians)
            SceneKit applies these rotations in the reverse order of the components:
               1. first roll
               2. then yaw
               3. then pitch
 */
@property(nonatomic) SCNVector3 eulerAngles API_AVAILABLE(macos(10.10));

/*!
 @property scale
 @abstract Determines the receiver's scale. Animatable.
 */
@property(nonatomic) SCNVector3 scale;

/*!
 @property pivot
 @abstract Determines the receiver's pivot. Animatable.
 */
@property(nonatomic) SCNMatrix4 pivot;

#pragma mark - Modifying the Node′s Visibility

/*!
 @property hidden
 @abstract Determines whether the receiver is displayed. Defaults to NO. Animatable.
 */
@property(nonatomic, getter=isHidden) BOOL hidden;

/*!
 @property opacity
 @abstract Determines the opacity of the receiver. Default is 1. Animatable.
 */
@property(nonatomic) CGFloat opacity;

/*!
 @property renderingOrder
 @abstract Determines the rendering order of the receiver.
 @discussion Nodes with greater rendering orders are rendered last. Defaults to 0.
 */
@property(nonatomic) NSInteger renderingOrder;

/*!
 @property castsShadow
 @abstract Determines if the node is rendered in shadow maps. Defaults to YES.
 */
@property(nonatomic) BOOL castsShadow API_AVAILABLE(macos(10.10));

/*!
 @property movabilityHint
 @abstract Communicates to SceneKit’s rendering system about how you want to move content in your scene; it does not affect your ability to change the node’s position or add animations or physics to the node. Defaults to SCNMovabilityHintFixed.
 */
@property(nonatomic) SCNMovabilityHint movabilityHint API_AVAILABLE(macos(10.12), ios(10.0), tvos(10.0));


#pragma mark - Managing the Node Hierarchy

/*!
 @property parentNode
 @abstract Returns the parent node of the receiver.
 */
@property(nonatomic, readonly, nullable) SCNNode *parentNode;

/*!
 @property childNodes
 @abstract Returns the child node array of the receiver.
 */
@property(nonatomic, readonly) NSArray<SCNNode *> *childNodes;

/*!
 @method addChildNode:
 @abstract Appends the node to the receiver’s childNodes array.
 @param child The node to be added to the receiver’s childNodes array.
 */
- (void)addChildNode:(SCNNode *)child;

/*!
 @method insertChildNode:atIndex:
 @abstract Insert a node in the childNodes array at the specified index.
 @param child The node to insert.
 @param index Index in the childNodes array to insert the node.
 */
- (void)insertChildNode:(SCNNode *)child atIndex:(NSUInteger)index;

/*!
 @method removeFromParentNode
 @abstract Removes the node from the childNodes array of the receiver’s parentNode.
 */
- (void)removeFromParentNode;

/*!
 @method replaceChildNode:with:
 @abstract Remove `child' from the childNode array of the receiver and insert 'child2' if non-nil in its position.
 @discussion If the parentNode of `child' is not the receiver, the behavior is undefined.
 @param oldChild The node to replace in the childNodes array.
 @param newChild The new node that will replace the previous one.
 */
- (void)replaceChildNode:(SCNNode *)oldChild with:(SCNNode *)newChild;



#pragma mark - Searching the Node Hierarchy

/*!
 @method childNodeWithName:recursively:
 @abstract Returns the first node found in the node tree with the specified name.
 @discussion The search uses a pre-order tree traversal.
 @param name The name of the node you are searching for.
 @param recursively Set to YES if you want the search to look through the sub-nodes recursively.
 */
- (nullable SCNNode *)childNodeWithName:(NSString *)name recursively:(BOOL)recursively;

/*!
 @method childNodesPassingTest:
 @abstract Returns the child nodes of the receiver that passes a test in a given Block.
 @discussion The search is recursive and uses a pre-order tree traversal.
 @param predicate The block to apply to child nodes of the receiver. The block takes two arguments: "child" is a child node and "stop" is a reference to a Boolean value. The block can set the value to YES to stop further processing of the node hierarchy. The stop argument is an out-only argument. You should only ever set this Boolean to YES within the Block. The Block returns a Boolean value that indicates whether "child" passed the test.
 */
- (NSArray<SCNNode *> *)childNodesPassingTest:(NS_NOESCAPE BOOL (^)(SCNNode *child, BOOL *stop))predicate;

/*!
 @method enumerateChildNodesUsingBlock:
 @abstract Executes a given block on each child node under the receiver.
 @discussion The search is recursive and uses a pre-order tree traversal.
 @param block The block to apply to child nodes of the receiver. The block takes two arguments: "child" is a child node and "stop" is a reference to a Boolean value. The block can set the value to YES to stop further processing of the node hierarchy. The stop argument is an out-only argument. You should only ever set this Boolean to YES within the Block.
 */
- (void)enumerateChildNodesUsingBlock:(NS_NOESCAPE void (^)(SCNNode *child, BOOL *stop))block API_AVAILABLE(macos(10.10));

/*!
 @method enumerateHierarchyUsingBlock:
 @abstract Executes a given block on the receiver and its child nodes.
 @discussion The search is recursive and uses a pre-order tree traversal.
 @param block The block to apply to the receiver and its child nodes. The block takes two arguments: "node" is a node in the hierarchy of the receiver (including the receiver) and "stop" is a reference to a Boolean value. The block can set the value to YES to stop further processing of the node hierarchy. The stop argument is an out-only argument. You should only ever set this Boolean to YES within the Block.
 */
- (void)enumerateHierarchyUsingBlock:(NS_NOESCAPE void (^)(SCNNode *node, BOOL *stop))block API_AVAILABLE(macos(10.12), ios(10.0), tvos(10.0));


#pragma mark - Converting Between Node Coordinate Systems

/*!
 @method convertPosition:toNode:
 @abstract Converts a position from the receiver’s coordinate system to that of the specified node.
 @param position A position specified in the local coordinate system of the receiver.
 @param node The node into whose coordinate system "position" is to be converted. If "node" is nil, this method instead converts to world coordinates.
 */
- (SCNVector3)convertPosition:(SCNVector3)position toNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.9));

/*!
 @method convertPosition:fromNode:
 @abstract Converts a position from the coordinate system of a given node to that of the receiver.
 @param position A position specified in the local coordinate system of "node".
 @param node The node from whose coordinate system "position" is to be converted. If "node" is nil, this method instead converts from world coordinates.
 */
- (SCNVector3)convertPosition:(SCNVector3)position fromNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.9));


/**
 @abstract Converts a vector from the coordinate system of a given node to that of the receiver.

 @param vector A vector specified in the local coordinate system the receiver.
 @param node The node defining the space from which the vector should be transformed. If "node" is nil, this method instead converts from world coordinates.

 @return vector transformed from receiver local space to node local space.
 */
- (SCNVector3)convertVector:(SCNVector3)vector toNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));


/**
 @abstract Converts a vector from the coordinate system of a given node to that of the receiver.

 @param vector A vector specified in the local coordinate system of "node".
 @param node The node defining the space to which the vector should be transformed to. If "node" is nil, this method instead converts from world coordinates.

 @return vector transformed from node space to reveiver local space.
 */
- (SCNVector3)convertVector:(SCNVector3)vector fromNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));


/*!
 @method convertTransform:toNode:
 @abstract Converts a transform from the receiver’s coordinate system to that of the specified node.
 @param transform A transform specified in the local coordinate system of the receiver.
 @param node The node into whose coordinate system "transform" is to be converted. If "node" is nil, this method instead converts to world coordinates.
 */
- (SCNMatrix4)convertTransform:(SCNMatrix4)transform toNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.9));

/*!
 @method convertTransform:fromNode:
 @abstract Converts a transform from the coordinate system of a given node to that of the receiver.
 @param transform A transform specified in the local coordinate system of "node".
 @param node The node from whose coordinate system "transform" is to be converted. If "node" is nil, this method instead converts from world coordinates.
 */
- (SCNMatrix4)convertTransform:(SCNMatrix4)transform fromNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.9));


#pragma mark - Managing the SCNNode′s physics body

/*!
 @property physicsBody
 @abstract The description of the physics body of the receiver.
 @discussion Default is nil.
 */
@property(nonatomic, retain, nullable) SCNPhysicsBody *physicsBody API_AVAILABLE(macos(10.10));


#pragma mark - Managing the Node′s Physics Field

/*!
 @property physicsField
 @abstract The description of the physics field of the receiver.
 @discussion Default is nil.
 */
@property(nonatomic, retain, nullable) SCNPhysicsField *physicsField API_AVAILABLE(macos(10.10));


#pragma mark - Managing the Node′s Constraints

/*!
 @property constraints
 @abstract An array of SCNConstraint that are applied to the receiver.
 @discussion Adding or removing a constraint can be implicitly animated based on the current transaction.
 */
@property(copy, nullable) NSArray<SCNConstraint *> *constraints API_AVAILABLE(macos(10.9));


#pragma mark - Accessing the Presentation Node

/*!
 @property presentationNode
 @abstract Returns the presentation node.
 @discussion Returns a copy of the node containing all the properties as they were at the start of the current transaction, with any active animations applied.
             This gives a close approximation to the version of the node that is currently displayed.
             The effect of attempting to modify the returned node in any way is undefined. The returned node has no parent and no child nodes.
 */
@property(nonatomic, readonly) SCNNode *presentationNode;


#pragma mark - Pause

/*!
 @property paused
 @abstract Controls whether or not the node's actions and animations are updated or paused. Defaults to NO.
 */
@property(nonatomic, getter=isPaused) BOOL paused API_AVAILABLE(macos(10.10));


#pragma mark - Overriding the Rendering with Custom OpenGL Code

/*!
 @property rendererDelegate
 @abstract Specifies the receiver's renderer delegate object.
 @discussion Setting a renderer delegate prevents the SceneKit renderer from drawing the node and lets you use custom OpenGL code instead.
             The preferred way to customize the rendering is to tweak the material properties of the different materials of the node's geometry. SCNMaterial conforms to the SCNShadable protocol and allows for more advanced rendering using GLSL.
             You would typically use a renderer delegate with a node that has no geometry and only serves as a location in space. An example would be attaching a particle system to that node and render it with custom OpenGL code.
 */
@property(nonatomic, assign, nullable) id <SCNNodeRendererDelegate> rendererDelegate;



#pragma mark - Hit Testing in the Node

/*!
 @method hitTestWithSegmentFromPoint:toPoint:options:
 @abstract Returns an array of SCNHitTestResult for each node in the receiver's sub tree that intersects the specified segment.
 @param pointA The first point of the segment relative to the receiver.
 @param pointB The second point of the segment relative to the receiver.
 @param options Optional parameters (see the "Hit test options" section in SCNSceneRenderer.h for the available options).
 @discussion See SCNSceneRenderer.h for a screen-space hit testing method.
 */
- (NSArray<SCNHitTestResult *> *)hitTestWithSegmentFromPoint:(SCNVector3)pointA toPoint:(SCNVector3)pointB options:(nullable NSDictionary<NSString *, id> *)options API_AVAILABLE(macos(10.9));


#pragma mark - Categories

/*!
 @property categoryBitMask
 @abstract Defines what logical 'categories' the receiver belongs too. Defaults to 1.
 @discussion Categories can be used to
                1. exclude nodes from the influence of a given light (see SCNLight.categoryBitMask)
                2. include/exclude nodes from render passes (see SCNTechnique.h)
                3. specify which nodes to use when hit-testing (see SCNHitTestOptionCategoryBitMask)
 */
@property(nonatomic) NSUInteger categoryBitMask API_AVAILABLE(macos(10.10));

#pragma mark - UIFocus support

/*!
 @property focusBehavior
 @abstract Controls the behavior of the receiver regarding the UIFocus system. Defaults to SCNNodeFocusBehaviorNone.
 */
@property(nonatomic) SCNNodeFocusBehavior focusBehavior API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

@end

@interface SCNNode (Transforms)

/*!
 @property localUp
 @abstract The local unit Y axis (0, 1, 0).
 */
@property(class, readonly, nonatomic) SCNVector3 localUp API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property localRight
 @abstract The local unit X axis (1, 0, 0).
 */
@property(class, readonly, nonatomic) SCNVector3 localRight API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property localFront
 @abstract The local unit -Z axis (0, 0, -1).
 */
@property(class, readonly, nonatomic) SCNVector3 localFront API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property worldUp
 @abstract The local unit Y axis (0, 1, 0) in world space.
 */
@property(readonly, nonatomic) SCNVector3 worldUp API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property worldRight
 @abstract The local unit X axis (1, 0, 0) in world space.
 */
@property(readonly, nonatomic) SCNVector3 worldRight API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @property worldFront
 @abstract The local unit -Z axis (0, 0, -1) in world space.
 */
@property(readonly, nonatomic) SCNVector3 worldFront API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/**
 Convenience for calling lookAt:up:localFront: with worldUp set to `self.worldUp`
 and localFront [SCNNode localFront].
 @param worldTarget target position in world space.
 */
- (void)lookAt:(SCNVector3)worldTarget API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/**
 Set the orientation of the node so its front vector is pointing toward a given
 target. Using a reference up vector in world space and a front vector in
 local space.

 @param worldTarget position in world space.
 @param worldUp the up vector in world space.
 @param localFront the front vector in local space.
 */
- (void)lookAt:(SCNVector3)worldTarget up:(SCNVector3)worldUp localFront:(SCNVector3)localFront API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/**
 Translate the current node position along the given vector in local space.

 @param translation the translation in local space.
 */
- (void)localTranslateBy:(SCNVector3)translation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/**
 Apply a the given rotation to the current one.

 @param rotation rotation in local space.
 */
- (void)localRotateBy:(SCNQuaternion)rotation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/**
 Apply a rotation relative to a target point in parent space.

 @param worldRotation rotation to apply in world space.
 @param worldTarget position of the target in world space.
 */
- (void)rotateBy:(SCNQuaternion)worldRotation aroundTarget:(SCNVector3)worldTarget API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

@end

/*!
 @category NSObject (SCNNodeRendererDelegate)
 @abstract The SCNNodeRendererDelegate protocol declares the methods that an instance of SCNNode invokes to let a delegate customize its rendering.
 */
@protocol SCNNodeRendererDelegate <NSObject>
@optional

/*!
 @method renderNode:renderer:arguments:
 @abstract Invoked when a node is rendered.
 @discussion The preferred way to customize the rendering is to tweak the material properties of the different materials of the node's geometry. SCNMaterial conforms to the SCNShadable protocol and allows for more advanced rendering using GLSL.
             You would typically use a renderer delegate with a node that has no geometry and only serves as a location in space. An example would be attaching a particle system to that node and render it with custom OpenGL code.
             Only drawing calls and the means to achieve them are supposed to be performed during the renderer delegate callback, any changes in the model (nodes, geometry...) would involve unexpected results.
 @param node The node to render.
 @param renderer The scene renderer to render into.
 @param arguments A dictionary whose values are SCNMatrix4 matrices wrapped in NSValue objects.
 */
- (void)renderNode:(SCNNode *)node renderer:(SCNRenderer *)renderer arguments:(NSDictionary<NSString *, id> *)arguments;

@end

@interface SCNNode (SIMD)

/*!
 @abstract Determines the receiver's transform. Animatable.
 @discussion The transform is the combination of the position, rotation and scale defined below. So when the transform is set, the receiver's position, rotation and scale are changed to match the new transform.
 */
@property(nonatomic) simd_float4x4 simdTransform API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's position. Animatable.
 */
@property(nonatomic) simd_float3 simdPosition API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's rotation. Animatable.
 @discussion The rotation is axis angle rotation. The three first components are the axis, the fourth one is the rotation (in radian).
 */
@property(nonatomic) simd_float4 simdRotation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's orientation as a unit quaternion. Animatable.
 */
@property(nonatomic) simd_quatf simdOrientation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's euler angles. Animatable.
 @dicussion The order of components in this vector matches the axes of rotation:
 1. Pitch (the x component) is the rotation about the node's x-axis (in radians)
 2. Yaw   (the y component) is the rotation about the node's y-axis (in radians)
 3. Roll  (the z component) is the rotation about the node's z-axis (in radians)
 SceneKit applies these rotations in the reverse order of the components:
 1. first roll
 2. then yaw
 3. then pitch
 */
@property(nonatomic) simd_float3 simdEulerAngles API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's scale. Animatable.
 */
@property(nonatomic) simd_float3 simdScale API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's pivot. Animatable.
 */
@property(nonatomic) simd_float4x4 simdPivot API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's position in world space (relative to the scene's root node).
 */
@property(nonatomic) simd_float3 simdWorldPosition API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's orientation in world space (relative to the scene's root node). Animatable.
 */
@property(nonatomic) simd_quatf simdWorldOrientation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

/*!
 @abstract Determines the receiver's transform in world space (relative to the scene's root node). Animatable.
 */
@property(nonatomic) simd_float4x4 simdWorldTransform API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

- (simd_float3)simdConvertPosition:(simd_float3)position toNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
- (simd_float3)simdConvertPosition:(simd_float3)position fromNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

- (simd_float3)simdConvertVector:(simd_float3)vector toNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
- (simd_float3)simdConvertVector:(simd_float3)vector fromNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

- (simd_float4x4)simdConvertTransform:(simd_float4x4)transform toNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
- (simd_float4x4)simdConvertTransform:(simd_float4x4)transform fromNode:(nullable SCNNode *)node API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

@property(class, readonly, nonatomic) simd_float3 simdLocalUp API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
@property(class, readonly, nonatomic) simd_float3 simdLocalRight API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
@property(class, readonly, nonatomic) simd_float3 simdLocalFront API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

@property(readonly, nonatomic) simd_float3 simdWorldUp API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
@property(readonly, nonatomic) simd_float3 simdWorldRight API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
@property(readonly, nonatomic) simd_float3 simdWorldFront API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

- (void)simdLookAt:(simd_float3)worldTarget API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
- (void)simdLookAt:(simd_float3)worldTarget up:(simd_float3)worldUp localFront:(simd_float3)localFront API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
- (void)simdLocalTranslateBy:(simd_float3)translation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

- (void)simdLocalRotateBy:(simd_quatf)rotation API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));
- (void)simdRotateBy:(simd_quatf)worldRotation aroundTarget:(simd_float3)worldTarget API_AVAILABLE(macos(10.13), ios(11.0), tvos(11.0), watchos(4.0));

@end

NS_ASSUME_NONNULL_END
