From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: boilerplate function for byte swapped
 smbus_write/read_word_data
Date: Tue, 4 Oct 2011 19:05:43 +0200
Message-ID: <20111004190543.44d57f18@endymion.delvare>
References: <1316699294-6936-1-git-send-email-jic23@cam.ac.uk>
	<4E8B3637.1030704@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E8B3637.1030704-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jonathan,

On Tue, 04 Oct 2011 17:37:11 +0100, Jonathan Cameron wrote:
> On 09/22/11 14:48, Jonathan Cameron wrote:
> > Reimplemented at least 17 times discounting error mangling cases
> > where it could be used.
>
> Anyone care to comment?

I will. I started reviewing your patch and pondering its inclusion, but
got sidetracked by more important issues. I will return to this
whenever I can.

-- 
Jean Delvare
