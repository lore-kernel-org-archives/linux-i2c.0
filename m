From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH] i2c: ocores: Add missing wake_up() call upon state change to STATE_DONE
Date: Fri, 16 Jun 2017 15:26:43 +0200
Message-ID: <871sqkhxm4.fsf@dell.be.48ers.dk>
References: <20170616092317.584-1-sr@denx.de>
        <87a858hz71.fsf@dell.be.48ers.dk>
        <7319c512-4301-8a33-5fc3-62486557a883@denx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34731 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbdFPN0q (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Jun 2017 09:26:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id 70so5038353wme.1
        for <linux-i2c@vger.kernel.org>; Fri, 16 Jun 2017 06:26:46 -0700 (PDT)
In-Reply-To: <7319c512-4301-8a33-5fc3-62486557a883@denx.de> (Stefan Roese's
        message of "Fri, 16 Jun 2017 15:04:14 +0200")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

>>>>> "Stefan" == Stefan Roese <sr@denx.de> writes:

Hi,

 >> It is close to 10 years ago since I last had access to any boards with
 >> the ocores controller, but the logic in ocores_process() indicates that
 >> the controller would generate another interrupt once the stop condition
 >> has been sent:
 >> 
 >> if ((i2c->state == STATE_DONE) || (i2c->state == STATE_ERROR)) {
 >> /* stop has been sent */
 >> oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
 >> wake_up(&i2c->wait);
 >> return;
 >> }
 >> 
 >> Do you not see this interrupt?

 > No. It took me quite some time last week, to notice this misbehavior
 > in this I2C driver. As the client (Goodix I2C touchscreen) always
 > returned only after more than 1 second from reading one I2C frame.

Funky. On what kind of platform / what VHDL source version is this? The
driver has now existed for more than 10 years and has had contributions
from a number of people, but this is the first time I hear about this
missing interrupt.

-- 
Bye, Peter Korsgaard
