From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 13/17] i2c: include/linux/i2c.h: fix a doc warning
Date: Tue, 17 Mar 2020 16:05:49 +0100
Message-ID: <20200317160549.3c23bbda@coco.lan>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
        <24cbf9166b21531186e5b6d37a3f9201f957abef.1584456635.git.mchehab+huawei@kernel.org>
        <20200317150322.GB1134@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgCQPF6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 17 Mar 2020 11:05:58 -0400
In-Reply-To: <20200317150322.GB1134@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org

Em Tue, 17 Mar 2020 16:03:22 +0100
Wolfram Sang <wsa@the-dreams.de> escreveu:

> On Tue, Mar 17, 2020 at 03:54:22PM +0100, Mauro Carvalho Chehab wrote:
> > Don't let non-letters inside a literal block without escaping it, as
> > the toolchain would mis-interpret it:
> > 
> > ./include/linux/i2c.h:518: WARNING: Inline strong start-string without end-string.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Shall I take this via I2C?

Yeah, feel free to pick it. The patches on this series are pretty
much independent from the others.

Thanks,
Mauro
