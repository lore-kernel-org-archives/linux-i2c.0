From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2c-tools: add compatibility for python2/3 to py-smbus
Date: Thu, 22 Jan 2015 14:37:15 +0100
Message-ID: <20150122143715.621e537d@endymion.delvare>
References: <CA+TH9VkT1K2aqAuNOLsGiU407OA4NYcMVaUakEQgSWLpMBBg2A@mail.gmail.com>
	<20150119230327.0224d0ba@endymion.delvare>
	<1421917018.21840.0@smtp.inria.fr>
	<20150122114958.3178f5f6@endymion.delvare>
	<1421933290.21840.1@smtp.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421933290.21840.1-YAXBhf1W29QAs8EywTwl9A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Mercier <michael.mercier-MZpvjPyXg2s@public.gmane.org>
Cc: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Renz, Bernhard" <bernhard.renz-//tT4aWmXyZBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 22 Jan 2015 14:28:10 +0100, Michael Mercier wrote:
> Thanks a lot!
> 
> It was a linking problem. I applied the patch and I it works for both 
> python2 and python3.
> 
> For those who are interested you can choose to the python version with 
> the PYTHON variable:
> make install # use "python" so it depends on your system configuration
> make install PYTHON=python2 # for python 2 explicitly
> make install PYTHON=python3 # for python 3 explicitly
> 
> 
> I have only tested read_i2c_block_data write_i2c_block_data for python 
> 3.2 and python 2.7.
> 
> I think you can push these patchs upstream.

Great, thanks for testing :)

-- 
Jean Delvare
SUSE L3 Support
