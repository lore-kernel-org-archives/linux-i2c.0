From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v10 3/4] misc: eeprom: at24: support pm_runtime control
Date: Thu, 23 Jan 2020 12:56:29 +0100
Message-ID: <CAMpxmJX=qh3oSgOtB6ciKG2tJW5VvYXEqw7ZWPM21_ynaXe++w@mail.gmail.com>
References: <20200116025637.3524-1-bibby.hsieh@mediatek.com> <20200116025637.3524-4-bibby.hsieh@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45816 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgAWL4k (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 23 Jan 2020 06:56:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so3046633qkl.12
        for <linux-i2c@vger.kernel.org>; Thu, 23 Jan 2020 03:56:40 -0800 (PST)
In-Reply-To: <20200116025637.3524-4-bibby.hsieh@mediatek.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Tomasz Figa <tfiga@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream <srv_heupstream@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-devicetree <devicetree@vger.kernel.org>

czw., 16 sty 2020 o 03:56 Bibby Hsieh <bibby.hsieh@mediatek.com> napisa=C5=
=82(a):
>
> Although in the most platforms, the power of eeprom are alway
> on, some platforms disable the eeprom power in order to meet
> low power request. This patch add the pm_runtime ops to control
> power to support all platforms.
>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>

Patch applied.

Bartosz
