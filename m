From: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] i2c-au1550: increase timeout waiting for transactions to finish
Date: Thu, 16 Jun 2011 08:00:47 +0200
Message-ID: <BANLkTi=T7C07ybWqXLmuYPqpjHtohewKrw@mail.gmail.com>
References: <1307881887-12676-1-git-send-email-manuel.lauss@googlemail.com>
	<20110615214009.GJ15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110615214009.GJ15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 15, 2011 at 11:40 PM, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> On Sun, Jun 12, 2011 at 02:31:27PM +0200, Manuel Lauss wrote:
>> Wait a bit longer for the I2C master transaction to finish.
>> With this change the WM8731 codec on the DB1300 board is now
>> reliably initialized.
>>
>> Tested on Db1200 and Db1300.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>
> If no-one else can think of a better fix, then this can go into -rc.
>
> Is there no register that could be read to find out if the system is
> busy?

That's what the function in the patch does: polls for the "master done"
bit to be set.  The timeout around it is just too short for some systems.

Next merge window is fine for this too.  For the current in-tree users this
driver actually works fine.

Manuel Lauss
