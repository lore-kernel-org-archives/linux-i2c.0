From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: add eeprom "at24,no-read-rollover" property
Date: Thu, 7 Dec 2017 09:06:08 -0500
Message-ID: <CAGngYiXLeVVSn-Fn9WGXd4zNmQ0SBZcuSAdrv-d2K=Wp0zHN0A@mail.gmail.com>
References: <1512487422-6284-1-git-send-email-svendev@arcx.com>
 <1512487422-6284-3-git-send-email-svendev@arcx.com> <20171206220404.oyqg6ckhdx7jtbxw@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:37479 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753991AbdLGOGJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Dec 2017 09:06:09 -0500
In-Reply-To: <20171206220404.oyqg6ckhdx7jtbxw@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sven Van Asbroeck <svendev@arcx.com>, mark.rutland@arm.com, wsa@the-dreams.de, Bartosz Golaszewski <brgl@bgdev.pl>, nsekhar@ti.com, Sakari Ailus <sakari.ailus@linux.intel.com>, David Lechner <david@lechnology.com>, javier@dowhile0.org, divagar.mohandass@intel.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c <linux-i2c@vger.kernel.org>

> at24 is not a vendor prefix. Either this is atmel specific and you want
> atmel,no-read-rollover or it is for all vendors at24 compatible eeproms
> and you want at24-no-read-rollover. Or just drop the at24 if this
> binding is in fact for just at24 eeproms as none of the other properties
> has at24 in them.

Bartosz, shall I rename
at24,no-read-rollover -> no-read-rollover ?
