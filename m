From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2c-tools: add compatibility for python2/3 to py-smbus
Date: Thu, 22 Jan 2015 11:25:05 +0100
Message-ID: <20150122112505.0750dd8a@endymion.delvare>
References: <CA+TH9VkT1K2aqAuNOLsGiU407OA4NYcMVaUakEQgSWLpMBBg2A@mail.gmail.com>
	<20150119230327.0224d0ba@endymion.delvare>
	<1421917018.21840.0@smtp.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421917018.21840.0-YAXBhf1W29QAs8EywTwl9A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Mercier <michael.mercier-MZpvjPyXg2s@public.gmane.org>
Cc: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Renz, Bernhard" <bernhard.renz-//tT4aWmXyZBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Thu, 22 Jan 2015 09:56:58 +0100, Michael Mercier wrote:
> Hi Jean,
> 
> I just tried you patch and I got an error when I try to import the 
> smbus python package:

Thanks for testing and reporting.

> import smbus
> 
> ImportError: 
> /usr/local/lib/python3.2/dist-packages/smbus.cpython-32mu.so: undefined 
> symbol: i2c_smbus_process_call
> 
> Any idea?

Not really, again I know nothing about python. But didn't you have the
same problem with Angelo's patch?

Maybe Angelo has an idea.

-- 
Jean Delvare
SUSE L3 Support
