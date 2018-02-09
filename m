From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: i2c_new_{secondary_device,dummy,device}() return type.
Date: Fri, 9 Feb 2018 10:01:09 +0000
Message-ID: <6f03d1e1-b542-99cb-7cfe-8eae9addd8d9@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:60705 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeBIKBO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Feb 2018 05:01:14 -0500
Content-Language: en-GB
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Wolfram,

As part of my work looking at using i2c_new_secondary_device() to move address
mappings into the device tree, it has become evident that the return code of the
i2c_new_secondary_device() is obfuscated, and is simply a valid client - or NULL.

This means that we must 'guess' as to whether the device failed due to a memory
allocation, or if the device address was already in use (perhaps a more common
failure).

Because of this - I would like to see the return codes of
i2c_new_secondary_device(), ic2_new_dummy(), and therefore i2c_new_device()
support returning ERR_PTR()s rather than a client or NULL.

These functions are used fairly extensively - thus it will be a fair bit of work
(or a good coccinelle script) - So I'd like to ask your opinion on the validity
of this task before I commence anything down that rabbit hole!

Any comments? Pre-ack/nack? (from anyone?)
