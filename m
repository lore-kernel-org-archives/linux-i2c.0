From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH] update module-init-tools to support the i2c
 subsystem
Date: Mon, 14 Jan 2008 20:46:25 +0100
Message-ID: <20080114204625.07293dce@hyperion.delvare>
References: <9e4733910712171839h214e0bc3q179266c86e5987b1@mail.gmail.com>
	<9e4733910801130714m1be16826jf240171972324d16@mail.gmail.com>
	<20080113163543.16e3d26b@hyperion.delvare>
	<9e4733910801130826l799e4897pe7380ccb973b5fd0@mail.gmail.com>
	<20080113184337.5d4cd546@hyperion.delvare>
	<9e4733910801131004i669276e2pde04b195dd10bd90@mail.gmail.com>
	<Pine.LNX.4.64.0801141154420.3058@vixen.sonytel.be>
	<20080114173835.5fe907db@hyperion.delvare>
	<Pine.LNX.4.64.0801141752450.3058@vixen.sonytel.be>
	<20080114185056.05b75fd1@hyperion.delvare>
	<3ae72650801141138t27666bcerd66e96f836d1ab2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754757AbYANTqi@vger.kernel.org>
In-Reply-To: <3ae72650801141138t27666bcerd66e96f836d1ab2b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 14 Jan 2008 20:38:28 +0100, Kay Sievers wrote:
> On Jan 14, 2008 6:50 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > I am under the impression that modules.*map are the old way to get
> > automatic driver loading and aliases are the new way to do the same.
> > But maybe that's just me.
> 
> Right, nothing on recent systems is using the map files. This patch
> should not be needed.
> The plan is to deprecate the creation of these files in depmod.

OK, great. Thanks for the info, Kay!

-- 
Jean Delvare
