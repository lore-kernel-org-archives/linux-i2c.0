From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Questions rgd. patch "eeprom: at24: support eeproms that do not
 auto-rollover reads"
Date: Fri, 8 Dec 2017 20:33:14 +0100
Message-ID: <c00c4e31-fee0-5666-d0a2-a3d53fd146c0@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44616 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbdLHTdX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Dec 2017 14:33:23 -0500
Received: by mail-wr0-f194.google.com with SMTP id l22so11768954wrc.11
        for <linux-i2c@vger.kernel.org>; Fri, 08 Dec 2017 11:33:23 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sven Van Asbroeck <svendev@arcx.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Sorry, I saw this patch only now and there my questions / remarks come
quite late. The intention of the change is clear, just the following:

In at24_adjust_read_count() there is the line
remainder = BIT(bits) - offset;

AFAICS we can have the case offset > BIT(bits). Imagine a 8 bit chip
with size 512 (2 addresses) and we try to read a few bytes from
offset 300. Then the line in question doesn't do what it's supposed
to do.

And a more general aspect: If the size is 512 but only 256 byte are
accessible then I doubt it's nice to create a nvmem provider with
size 512. Wouldn't it be better to adjust byte_len to reflect the
accessible size? Then we also wouldn't need the check in
at24_adjust_read_count.

Rgds, Heiner
