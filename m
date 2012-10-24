From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i2c-ocores: Add support for the GRLIB port of the controller and custom getreg and setreg functions
Date: Wed, 24 Oct 2012 13:48:04 +0200
Message-ID: <87bofsm6q3.fsf@macbook.be.48ers.dk>
References: <1351004637-11049-1-git-send-email-andreas@gaisler.com>
	<1351004637-11049-3-git-send-email-andreas@gaisler.com>
	<87sj95lywu.fsf@macbook.be.48ers.dk> <5087AF46.1070707@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5087AF46.1070707-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> (Andreas Larsson's message of
	"Wed, 24 Oct 2012 11:05:10 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Andreas" == Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> writes:

 >> Are all platforms using i2c-ocores guaranteed to provide ioread32be /
 >> iowrite32be or should we stick an #ifdef CONFIG_SPARC around it?

 Andreas> As far as I can see, after digging around, the only platforms that
 Andreas> have ioread/write32, but not ioread/write32be are frv and mn10300. Do
 Andreas> you know if those platforms are using i2c-ocores?

Not to my knowledge, no. In that case:

Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>

-- 
Bye, Peter Korsgaard
