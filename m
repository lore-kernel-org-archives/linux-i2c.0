From: Andreas Werner <wernerandy@gmx.de>
Subject: Re: [PATCH v2] I2C: busses: i2c-eg20t Do not print error message in
 syslog if no ACK received
Date: Sun, 17 Nov 2013 17:53:29 +0100
Message-ID: <20131117165329.GA1562@thinkpad.fritz.box>
References: <1384678731-10399-1-git-send-email-wernerandy@gmx.de>
 <20131117110846.GA3093@katana>
 <20131117123902.GA3834@awedesk.fritz.box>
 <20131117121809.GC3093@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131117121809.GC3093@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: khali@linux-fr.org, jacmet@sunsite.dk, hskinnemoen@gmail.com, dianders@chromium.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Nov 17, 2013 at 01:18:09PM +0100, Wolfram Sang wrote:
> 
> > Is there another reason why pch_i2c_getack returned EPROTO?
> > May be ENXIO was introduced later?
> 
> Imperfect review :)
> 
> > I think we can just replace the -EIO with -ENXIO or do you want to pick up the return
> > vale of pch_i2c_getack and return that ?
> 
> The latter. As a rule of thumb, it is usually more sustainable to pass
> through error codes. Overloading them should only be done when really
> necessary IMO.
> 
Ok, if that will be ok in pch_i2c_wait_for_check_xfer i will resend 
the patch.

        ret = pch_i2c_getack(adap);

        if (ret)
                pch_dbg(adap, "Receive NACK for slave address setting\n");

        return (int)ret;

Regards 
Andy
