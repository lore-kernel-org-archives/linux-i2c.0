From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Re: Re: [PATCH]  I2C: Change the value of octeon i2c adapter
 timeout value
Date: Tue, 23 Apr 2013 18:27:51 +0200
Message-ID: <20130423162751.GA3228@the-dreams.de>
References: <11281802.80061366444168759.JavaMail.weblogic@epml02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <11281802.80061366444168759.JavaMail.weblogic@epml02>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: EUNBONG SONG <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

what mail client do you use? It seems to break message threading on my side :(


> > Have you been writing to EEPROMS? Their erase/write cycle might be
> > longer. But I am not forcing you to change the value, just giving some
> > suggestions.
> 
> My board has i2c mux, temp sensor, eeprom.  And I added some debugging code for measuring i2c response time as below  and 
> run i2c operation for each device. 
> The maximum respeonse time was 500usec(under 1msec). So 20 msec is enough for adapter timeout. 

Well, OK, I don't mind. We can increase it later if needed.

Applied to for-next, thanks! Please have a look later how I changed your
commit messages to see the preferred style.
