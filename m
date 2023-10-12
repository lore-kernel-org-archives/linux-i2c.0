Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45D5CDB46E
	for <linux-i2c@archiver.kernel.org>; Thu, 12 Oct 2023 12:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343872AbjJLMvZ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 12 Oct 2023 08:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343971AbjJLMvY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Oct 2023 08:51:24 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E1BA;
        Thu, 12 Oct 2023 05:51:20 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3FBE786E47;
        Thu, 12 Oct 2023 14:51:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1697115075;
        bh=Z0GVvRTU4DqGmzGQ3SLCsI4y7zhSR2KUN62lpuh4DCQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=InpFHdPnC/bSccQpoGQsku8QCThoCrpJqqkoIOE51AjkW89aEeAuXbVXuDwyGL7EG
         XYjfDORNdQJ1ePFaFAmeYXPZ3s8j9k69UaOOt59GdMJBset4fTPyqEo+Kwp3waJED1
         8Ue2nr1B2Wlb+2DZnEx8QfO342+e1KtHRHztbRmTX47+VHBzGuHRsBhOmIhMdLNcbB
         YjzmA+a8oPzxNZnwiXNeJygLqmVUzpOx8Ns4o6BYZmtzzoolsPJTbv6nF97JENlgMF
         yDmyAhNwKH5KISBNCU4Z71qDy2srll5hkUloz4W7fFARl0ReCAFcjbYfPBoARGmewi
         FzqHjOfCZKOlA==
Message-ID: <d8eefb50-dc68-4df2-9f7b-b2a90c6d89f1@denx.de>
Date:   Thu, 12 Oct 2023 14:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: at24: add ST M24C32-D Additional Write
 lockable page
To:     Rob Herring <robh@kernel.org>
Cc:     linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
References: <20231010190926.57674-1-marex@denx.de>
 <20231012115719.GA291445-robh@kernel.org>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20231012115719.GA291445-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 10/12/23 13:57, Rob Herring wrote:
> On Tue, Oct 10, 2023 at 09:09:25PM +0200, Marek Vasut wrote:
>> The ST M24C32-D behaves as a regular M24C32, except for the -D variant
>> which uses up another I2C address for Additional Write lockable page.
>> This page is 32 Bytes long and can contain additional data. Document
>> compatible string for it, so users can describe that page in DT. Note
>> that users still have to describe the main M24C32 area separately as
>> that is on separate I2C address from this page.
> 
> So 2 nodes for 1 device? Wouldn't it make more sense for the 1 node to
> have 2 addresses?

It would, if the 32 Byte Additional Write lockable page was somehow 
related to the main area, but it doesn't seem to be, except that they 
are both on single chip.
