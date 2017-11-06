From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/1] at24: support eeproms that do not roll over page
 reads.
Date: Mon, 6 Nov 2017 14:26:34 -0600
Message-ID: <20171106202634.tuwdi76w6bmaqf4y@rob-hp-laptop>
References: <1509543843-27697-1-git-send-email-svendev@arcx.com>
 <1509543843-27697-2-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:54046 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbdKFU0g (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 6 Nov 2017 15:26:36 -0500
Content-Disposition: inline
In-Reply-To: <1509543843-27697-2-git-send-email-svendev@arcx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sven Van Asbroeck <svendev@arcx.com>
Cc: mark.rutland@arm.com, wsa@the-dreams.de, nsekhar@ti.com, david@lechnology.com, javier@dowhile0.org, brgl@bgdev.pl, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On Wed, Nov 01, 2017 at 09:44:03AM -0400, Sven Van Asbroeck wrote:
> Some eeproms in the at24 family do not roll over page reads,
> e.g. the Microchip 24AA16/24LC16B. On those eeproms, reads
> that straddle block boundaries will not work correctly.
> 
> Solution:
> Implement read rollover in the driver. To enable it, add the
> AT24_FLAG_NO_RDROL flag to the eeprom entry in the
> device_id table, or add 'no-read-rollover' to the eeprom
> devicetree entry.
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  .../devicetree/bindings/eeprom/eeprom.txt          |  5 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/misc/eeprom/at24.c                         | 47 +++++++++++-----------
>  include/linux/platform_data/at24.h                 |  1 +
>  3 files changed, 29 insertions(+), 24 deletions(-)
