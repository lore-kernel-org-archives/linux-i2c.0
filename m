From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v4 00/14] ARM: dts: r8a779x: use demuxer for I2C
Date: Thu, 10 Nov 2016 17:12:18 +0900
Message-ID: <CANqRtoSeao_aEvEvEn5uw4DTdWb_+FW62tK9DBVxyeRBTo6TKQ@mail.gmail.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161109084406.GA22213@verge.net.au> <20161109172813.GA1545@katana>
 <CANqRtoRwSh602rjbHA2qo=XHyimpyyi_T=0sh2A4NOfzzVB+oQ@mail.gmail.com> <20161110075719.GA1436@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34872 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754290AbcKJIMU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 10 Nov 2016 03:12:20 -0500
In-Reply-To: <20161110075719.GA1436@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-I2C <linux-i2c@vger.kernel.org>

Hi Wolfram,

On Thu, Nov 10, 2016 at 4:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> I think postponing merge of patches is one thing but I don't think
>> dropping them forever is a long term solution. I think we should have
>
> Just to make sure because you wrote 'them': I talked about one patch of
> the series, not the whole series, namely DVFS. Because Lager is the only
> board we have where you can multiplex DVFS between IIC and I2C, no GPIO
> option here. All other SoCs have dedicated pins for DVFS which you can't
> mux to anything else at all.

Sorry I meant "one patch". As a workaround it is fine, but dropping
one patch still does not change the way the hardware is designed.
Being able to change the I2C master controller between the on-chip I2C
device and the on-chip IIC device is still something that the hardware
supports but we cannot seem to do without further software
development.

Thanks,

/ magnus
