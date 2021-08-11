Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8A0C4320A
	for <linux-i2c@archiver.kernel.org>; Wed, 11 Aug 2021 21:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CBF6104F
	for <linux-i2c@archiver.kernel.org>; Wed, 11 Aug 2021 21:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhHKVFo (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKVFn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 11 Aug 2021 17:05:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B20FC061765
        for <linux-i2c@vger.kernel.org>; Wed, 11 Aug 2021 14:05:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso5400017wms.5
        for <linux-i2c@vger.kernel.org>; Wed, 11 Aug 2021 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E8Foko+N4R90eWvN05z4+YINLOy3dZRJbJ431JUVUYA=;
        b=ri12je8jr4Jhi61XaM3R3HG51Se3nIdkYV3yOpejuYFAu55dL4RD9OAWWdUxz3yDD4
         h1tazpzttqaKyVUuw66A/0iuEkPWk0armEaQhbSi4qDLUlTELG5AOOB/5GklV+nfINBM
         m/AWr+thz5yK/wWVw0Zg4Ci8PZHzVJb90jgWfQq+HxXV4fF52oDo3DtCZFP6J60FjxUl
         WfaJxWnFjIYASwW8wyNc4L9W20LREVUd/H8/Ee2Duhk1RhY9ugGZcaw/wxbu9YPZqNvf
         dBzovCMdPaJIbddylFu3ZAF8j2KyBoJnuAlHIwV2gYxcXhxm13kQizn7oWuy7mKqTK8X
         0hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E8Foko+N4R90eWvN05z4+YINLOy3dZRJbJ431JUVUYA=;
        b=PsRH+lHNAzKFMe7YlY9jGPKwCHdmvgc99BJnqUIRxTolV9vYfSbi0jHAw22BUmSk3h
         U3/sV6FK5n1IQWQ3v1DLrQahgjbLiB9y7Ec7DwRJG0iG6/ZeqISx5/mkcIqZbM7G7amQ
         L3LaCbl9EQO+1L4fgkgdlnHO1DXC5ABpH6Al24O+WoBbLPFstYcdDR15HOEGOBsMs47p
         AfsWZ4jgn+9ul/PCm64XNr7nyEnEf9pdFQxxxNH/lVCM4mtv7lauCi1m41lnhFjyYltB
         aXrz4Pw8WDgh3gRwsjWxYWp6J281YglAtSOZb6QlubTwIhrptVRg+UZ2q+zZYJ0EALNw
         HkWw==
X-Gm-Message-State: AOAM532cC52HM7K0G4jj0dasjEg6SMoxM27yxQNCEpGbv0EohAy1uIfd
        Gbu8SrIa/K4my8r2Gm+gCNrxgd2slWMl9w==
X-Google-Smtp-Source: ABdhPJzFy0GpfzHgyPtint4ONIdPSUr9OjJjCC08vHoDMEdsskKxxccNQLhiTP34erkKomB3ZhGO1g==
X-Received: by 2002:a05:600c:35d1:: with SMTP id r17mr459149wmq.175.1628715917971;
        Wed, 11 Aug 2021 14:05:17 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f10:c200:988:dfda:c500:b22? (p200300ea8f10c2000988dfdac5000b22.dip0.t-ipconnect.de. [2003:ea:8f10:c200:988:dfda:c500:b22])
        by smtp.googlemail.com with ESMTPSA id r23sm467864wrr.14.2021.08.11.14.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 14:05:17 -0700 (PDT)
Subject: Re: [PATCH v2 4/9] i2c: i801: Improve is_dell_system_with_lis3lv02d
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <e46ac7c1-1bb0-2caf-58e6-2fcaa89d30ae@gmail.com>
 <effeb0c0-36cb-afc4-4d9a-7ef348c928ae@gmail.com>
 <YRPwsvJ7T+NcPepu@smile.fi.intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <8d6e7c48-839a-44d7-3e4d-643dc79e20c5@gmail.com>
Date:   Wed, 11 Aug 2021 22:28:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRPwsvJ7T+NcPepu@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 11.08.2021 17:45, Andy Shevchenko wrote:
> On Fri, Aug 06, 2021 at 11:15:15PM +0200, Heiner Kallweit wrote:
>> Replace the ugly cast of the return_value pointer with proper usage.
>> In addition use dmi_match() instead of open-coding it.
> 
> ...
> 
>> -	acpi_get_devices(NULL, check_acpi_smo88xx_device, NULL,
>> -			 (void **)&found);
>> +	acpi_get_devices(NULL, check_acpi_smo88xx_device, NULL, &err);
>>  
>> -	return found;
>> +	return !IS_ERR(err);
> 
> Shouldn't you also check the status of acpi_get_device()?
> 
This shouldn't be needed because err isn't touched if function fails.
