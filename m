From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
Date: Fri, 26 Oct 2018 19:45:29 +0200
Message-ID: <87woq438li.fsf@dell.be.48ers.dk>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
        <20180625161303.7991-4-federico.vaga@cern.ch>
        <CACXmViZK=4dXYN-399=U6UDJDv4NuTQ2LHEfgh8UbeUJLJp_QQ@mail.gmail.com>
        <4222986.LvGMQbjSbS@pcbe13614>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4222986.LvGMQbjSbS@pcbe13614> (Federico Vaga's message of "Wed,
        24 Oct 2018 11:51:19 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Federico" == Federico Vaga <federico.vaga@cern.ch> writes:

Hi,

 >> > -       } else
 >> > +       } else {
 >> > 
 >> >                 msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
 >> > 
 >> > +       }
 >> 
 >> This looks unrelated to $SUBJECT.

 > Do you prefer a different patch just for styling?

Yes please, it is a lot nicer to keep functional changes from pure style
changes.

 >> > +static void ocores_poll_wait(struct ocores_i2c *i2c)
 >> > +{
 >> > +       int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits */
 >> > +       u8 loop_on;
 >> > +
 >> > +       usleep_range(sleep_min, sleep_min + 10);
 >> 
 >> Where does this 10 come from?

 > It's true, it's just a random number. It can be zero as well, and we ask the 
 > system to just sleep for that amount of time. 

 > (1) usleep_range(sleep_min, sleep_min);

Or just usleep(sleep_min);

 >> 
 >> > +       if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR)
 >> > +               loop_on = OCI2C_STAT_BUSY;
 >> > +       else
 >> > +               loop_on = OCI2C_STAT_TIP;
 >> > +       while (oc_getreg(i2c, OCI2C_STATUS) & loop_on)
 >> > +               ;
 >> 
 >> How would an I2C transmission timeout be handled here?

 > There is the assumption that the hardware is alive and what we read from 
 > oc_getreg() is correct. With this assumption, when there is a timeout this 
 > will happen:
 > 1. STOP command (previous patch)
 > 2. both TIP and BUSY will become zero at some point and we get out from the 
 > loop

 > I can see now that there are cases when it may loop forever: for example if 
 > the device is broken and it does answer always with 0xFFFF: we should not 
 > break the host as well :)

 > I can fix this.

Thanks!

-- 
Bye, Peter Korsgaard
