From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2c-tools: add compatibility for python2/3 to py-smbus
Date: Mon, 26 Jan 2015 12:46:15 +0100
Message-ID: <20150126124615.7fd1f64f@endymion.delvare>
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
> I have only tested read_i2c_block_data write_i2c_block_data for python 
> 3.2 and python 2.7.
> 
> I think you can push these patchs upstream.

I committed both patches. I also added python 3 support to the stable
branch.

-- 
Jean Delvare
SUSE L3 Support
