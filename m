From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Sluggish AT91 I2C driver causes SMBus timeouts
Date: Fri, 13 Oct 2017 14:29:35 +0100
Message-ID: <20171013142935.14ef302e@alans-desktop>
References: <3d83fd8b-ade9-da10-3364-2afefa2e90af@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:51882 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753460AbdJMN3m (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 13 Oct 2017 09:29:42 -0400
In-Reply-To: <3d83fd8b-ade9-da10-3364-2afefa2e90af@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Thu, 12 Oct 2017 13:35:17 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> I have encountered an "interesting" bug. It silently corrupts data
> and is generally nasty...
> 
> On an I2C bus, driven by the at91 driver and DMA (an Atmel
> sama5d31 chip), I have an 256 byte eeprom (NXP SE97BTP). I'm using
> Linux v4.13.

If your force the transfer to PIO does it behave ? Does the controller in
fact need to siwtch to PIO for SMBUS ?

Alan
