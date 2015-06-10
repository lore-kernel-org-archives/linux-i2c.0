From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: clock driver
Date: Tue, 9 Jun 2015 17:40:43 -0700
Message-ID: <5577878B.1080402@freescale.com>
References: <5564C58B.9050400@freescale.com> <20150526223829.GA26454@roeck-us.net> <55650DBA.5000304@freescale.com> <5565108D.2020502@freescale.com> <20150527173055.22384.74368@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150527173055.22384.74368@quantum>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andrey-MoRZu3FOBbXQT0dZR+AlfA@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rabeeh-UBr1pzP51AyaMJb+Lgu22Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Michael,

I have rewritten the driver to use CCF. It will be sent for review when ready.

I have some questions, hoping you can shed some light on them.

Q1: What does of_clk_add_provider do?
I read the code and comment. It registers a clock provider for a node. How is it
used after registration?

Q2: What do you suggest to name multiple clocks on PCIe (FPGA) cards?
I will have multiple cards with multiple clock chips on each. The clock driver
can handle clocks on each chip. Is it recommended to create unique names by the
driver? Is there any example to follow?

Q3: Is there a guideline or an API to create sub folder under debugfs "clk"?

Thanks a lot.

York
