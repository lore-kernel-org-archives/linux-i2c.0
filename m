From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Question on device tree bindings for I2C
Date: Mon, 7 Dec 2015 16:03:26 +0100
Message-ID: <CAOAejn3Z4t1U4zv-Xd_WhWR0taaxw8Bgxu6t=aLiW0GKaAr6mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35199 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbbLGPD1 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Dec 2015 10:03:27 -0500
Received: by pfu207 with SMTP id 207so66148988pfu.2
        for <linux-i2c@vger.kernel.org>; Mon, 07 Dec 2015 07:03:26 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org

Hi Wolfram,

I am going to send to the mailing list a patch series to add a new
driver to support I2C controller embedded in some STM32 platforms.

I am wondering what is the correct way to name the file that will
describe the STM32 I2C bindings.
Indeed, in the Documentation/devicetree/bindings/i2c folder, the rule
i2c-xxx.txt seems to be the common rule but we also have some file
like  "vendor,platform-i2c.txt" like brcm,bcm2835-i2c.txt.

Do you have any recommendation for that purpose ?

Thanks in advance.

BR,
Cedric
