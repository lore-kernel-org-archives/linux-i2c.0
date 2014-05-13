From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: Re: how to get SPD in Sandy or Ivy bridge ?
Date: Tue, 13 May 2014 13:30:34 -0700
Message-ID: <537280EA.9090100@mit.edu>
References: <53631823.9050208@yandex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53631823.9050208-zJpx2rpV7r/QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Black.S" <Black.S52-zJpx2rpV7r/QT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

[moved]

On 05/01/2014 08:59 PM, Black.S wrote:
> Hello
> 
> For get SPD earle I used utility decode-dimms that use kernel module
> eeprom. But now it does not work, as I understand it because module
> eeprom in Sandy Bridge with integrated memory controller no longer
> communicates with EEPROM.
> 
> I was hoping that getting SPD will be support later but support is still
> not there.
> 
> May be this question is not for topic of this forum, but I do not know
> where to properly place the question.

The i2c-imc driver (google for it or look in luto/linux.git on
git.kernel.org) should be able to do it on Sandy Bridge LGA2011.  I hope
to update the driver for Ivy Bridge soon.

Merging the driver is currently stalled due to the fact that no one has
verified that running the driver is safe.  It seems to be okay, but I'm
hoping to get some kind of real information from Intel soon.

--Andy
