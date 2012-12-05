From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 11/14] HID: i2c-hid: remove unneeded test in
 i2c_hid_remove
Date: Wed, 5 Dec 2012 11:30:58 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212051130240.17055@pobox.suse.cz>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com> <1354634875-5182-12-git-send-email-benjamin.tissoires@gmail.com> <20121205111352.4d7e7876@endymion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20121205111352.4d7e7876@endymion.delvare>
Sender: linux-input-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 5 Dec 2012, Jean Delvare wrote:

> > ihid can not be null, so there are no reasons to test it.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > index 4e3f80b..2b49929 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > @@ -890,9 +890,6 @@ static int __devexit i2c_hid_remove(struct i2c_client *client)
> >  	struct i2c_hid *ihid = i2c_get_clientdata(client);
> >  	struct hid_device *hid;
> >  
> > -	if (WARN_ON(!ihid))
> > -		return -1;
> > -
> >  	hid = ihid->hid;
> >  	hid_destroy_device(hid);
> >  
> 
> This leaves <linux/bug.h> included for no good reason. Please remove it
> too.

I have applied the patch, and removed the superfluous include as well, 
thanks for spotting that, Jean.

-- 
Jiri Kosina
SUSE Labs
