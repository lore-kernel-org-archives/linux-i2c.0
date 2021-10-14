Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0BDC433EF
	for <linux-i2c@archiver.kernel.org>; Thu, 14 Oct 2021 16:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9545E60EBB
	for <linux-i2c@archiver.kernel.org>; Thu, 14 Oct 2021 16:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhJNQs7 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 14 Oct 2021 12:48:59 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36523 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhJNQsz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Oct 2021 12:48:55 -0400
Received: by mail-ot1-f45.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so9077970otk.3;
        Thu, 14 Oct 2021 09:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ujHcRvCirmqYyP/G9OIlII3v2dI92/qrzyNIDCv4hDA=;
        b=lF4Inqduty5EzJ6FSMZRoXYLoJibs8KFb7emvgAIh2WdlEGUH9v0VwhkQ18AgMYP/D
         1atEEZbsrNKlSTsEagy+hHwyS4E//xczcPYrw8MYDSHCbACJ3hlGGe3j+n8/77XCC7oA
         3CKMNelDc1arTmisXhrzCXuRXIpaeunqNfrDQhlz2cYLe1XNz44Frj5bJ+bJHe1l9HZj
         Z7I6jaqgIAkIUbQBwr4USHrZqlXnwK4uHjOn7uXd1imfWvubiaU6dI/len88hZFjXclH
         l5C2DK8W/jGF2Az4GFy2gqCxHC/yl5rU4JF2s8qAaTqaW9WiaQezOcuEoxahdIC2zVYP
         YdNg==
X-Gm-Message-State: AOAM531XVlUum8ztEW0w5MLRqMhiT51kWbV0xjFk174t41SA8ew4jO9x
        Rk8c03sWGGgTn3xvQiZEvg==
X-Google-Smtp-Source: ABdhPJxVtfNRxyb4DCtNbXuq+R80ABq48UJGCYahUiRCZ8f5QF2NeHuamoz+are7uUC04PrCG01Myw==
X-Received: by 2002:a9d:4616:: with SMTP id y22mr3493410ote.215.1634230010558;
        Thu, 14 Oct 2021 09:46:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j6sm532430oot.18.2021.10.14.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 09:46:50 -0700 (PDT)
Received: (nullmailer pid 3518479 invoked by uid 1000);
        Thu, 14 Oct 2021 16:46:48 -0000
Date:   Thu, 14 Oct 2021 11:46:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>
List-Id: <soc.lore.kernel.org>
Cc:     jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, p.zabel@pengutronix.de,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, dinguyen@kernel.org,
        p.yadav@ti.com, Tudor.Ambarus@microchip.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, sre@kernel.org,
        thunder.leizhen@huawei.com, Jonathan.Cameron@huawei.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ka@semihalf.com, tn@semihalf.com, jam@semihalf.com,
        amstan@google.com
Subject: Re: [PATCH v2 2/4] dt-bindings: add bus number property
Message-ID: <YWhe+NfiY0l0ILrA@robh.at.kernel.org>
References: <20211005143748.2471647-1-pan@semihalf.com>
 <20211005143746.xE5rCkt-P_XlNkn9bJ8ZqYPY4nQQ7doqzSd4FrAlICY@z>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211005143746.xE5rCkt-P_XlNkn9bJ8ZqYPY4nQQ7doqzSd4FrAlICY@z>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Tue, Oct 05, 2021 at 04:37:46PM +0200, Paweł Anikiel wrote:
> On SoCFPGA systems, it's desireable to have fixed numbering for
> i2c busses, while being able to enable/disable them (e.g. have i2c1
> be mapped to /dev/i2c-1, even though i2c0 is disabled). This can also
> be achieved using devicetree aliases (see i2c_add_adapter). However,
> having the driver be self-contained without relying on aliases is more
> robust.

Your header is a bit weird as you have 2 Message-IDs:

> Message-ID: <20211005143748.2471647-3-pan@semihalf.com>                                                                                                     
> X-Mailer: git-send-email 2.25.1                                                                                                                             
> Message-ID: <20211005143746.xE5rCkt-P_XlNkn9bJ8ZqYPY4nQQ7doqzSd4FrAlICY@z>                                                                                  
