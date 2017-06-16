From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH] i2c: ocores: Add missing wake_up() call upon state change to STATE_DONE
Date: Fri, 16 Jun 2017 14:52:34 +0200
Message-ID: <87a858hz71.fsf@dell.be.48ers.dk>
References: <20170616092317.584-1-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36359 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753765AbdFPMwm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Jun 2017 08:52:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id d17so4875131wme.3
        for <linux-i2c@vger.kernel.org>; Fri, 16 Jun 2017 05:52:37 -0700 (PDT)
In-Reply-To: <20170616092317.584-1-sr@denx.de> (Stefan Roese's message of
        "Fri, 16 Jun 2017 11:23:17 +0200")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

>>>>> "Stefan" == Stefan Roese <sr@denx.de> writes:

 > I've noticed that this driver adds a timeout pause of 1 second after
 > each xfer. This is due to the wait_event_timeout() call in ocores_xfer()
 > using a "HZ" timeout value and a missing call to wake_up() in
 > ocores_process() called by the interrupt handler when the state changes
 > to STATE_DONE at the end of the frame.

 > This patch adds the missing call resulting in the removal of this 1
 > second timeout delay after each xfer.

 > Signed-off-by: Stefan Roese <sr@denx.de>
 > Cc: Wolfram Sang <wsa@the-dreams.de>
 > ---
 >  drivers/i2c/busses/i2c-ocores.c | 1 +
 >  1 file changed, 1 insertion(+)

 > diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
 > index 34f1889a4073..5f8395ea0106 100644
 > --- a/drivers/i2c/busses/i2c-ocores.c
 > +++ b/drivers/i2c/busses/i2c-ocores.c
 > @@ -191,6 +191,7 @@ static void ocores_process(struct ocores_i2c *i2c)
 >  		} else {
>                       i2c-> state = STATE_DONE;
 >  			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
 > +			wake_up(&i2c->wait);
 >  			return;

It is close to 10 years ago since I last had access to any boards with
the ocores controller, but the logic in ocores_process() indicates that
the controller would generate another interrupt once the stop condition
has been sent:

	if ((i2c->state == STATE_DONE) || (i2c->state == STATE_ERROR)) {
		/* stop has been sent */
		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
		wake_up(&i2c->wait);
		return;
	}

Do you not see this interrupt?

-- 
Bye, Peter Korsgaard
