From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] i2c: cadence: match return type of
 wait_for_completion_timeout
Date: Sun, 8 Feb 2015 08:50:18 -0800
Message-ID: <20150208165018.GH9214@xsjandreislx>
References: <1423400155-28078-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423400155-28078-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Michal Simek <michal.simek@xilinx.com>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 2015-02-08 at 07:55AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. =
as
> ret is only used for wait_for_completion_timeout anyway the type is s=
imply=20
> changed to unsigned long.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reviewed-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>

	S=C3=B6ren
