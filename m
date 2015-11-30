From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 1/3] i2c: at91: add setting HOLD field of TWIHS_CWGR via
 DT
Date: Mon, 30 Nov 2015 16:57:23 +0100
Message-ID: <20151130155723.GA29282@odux.rfo.atmel.com>
References: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
 <20151130151319.GM1513@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:52231 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbK3P5X (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 30 Nov 2015 10:57:23 -0500
Content-Disposition: inline
In-Reply-To: <20151130151319.GM1513@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, plagnioj@jcrosoft.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cyrille.pichen@atmel.com, Wenyou Yang <wenyou.yang@atmel.com>

On Mon, Nov 30, 2015 at 04:13:20PM +0100, Wolfram Sang wrote:
> On Tue, Nov 24, 2015 at 02:47:40PM +0100, Ludovic Desroches wrote:
> > From: Wenyou Yang <wenyou.yang@atmel.com>
> > 
> > Add the HOLD field management. Some i2c devices need a longer data hold
> > time than the one given in the i2c bus specification. Since this value
> > depends on the i2c device connected to the bus, add a DT property to
> > configure it: "atmel,twd-hold-cycles".
> 
> We already have "i2c-sda-hold-time-ns". Can you use that one? Sorry that
> this is not obviously documented, I am working on it...
> 

I think we can use it, I'll rework the patch to convert duration in
number of cycles.
