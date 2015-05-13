From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] i2c: axxia: Add bus recovery functionality
Date: Wed, 13 May 2015 08:19:59 +0200
Message-ID: <5552ED0F.7000200@gmx.de>
References: <553F7B11.5000204@nokia.com> <20150512191211.GC4449@schokonusskuchen.bad>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150512191211.GC4449-oo5tB6JMkjKRinMKxDlMNPwbnWRJjS81@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wilshire Jay <jay.wilshire.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Lawnick Michael <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Am 12.05.2015 um 21:12 schrieb Wolfram Sang:
> Doesn't look right. -EAGAIN means arbitration lost which is not a
> condition to reset the bus in a multi-master setup.

IMHO in multi-master scenario bus recovery is never save. There is need 
of higher level synchronization to find out whether any master is active.

-- 
Michael
