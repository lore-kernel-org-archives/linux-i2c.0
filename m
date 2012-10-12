From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] i2c: change the id to let the i2c device work
Date: Fri, 12 Oct 2012 14:53:02 +0900
Message-ID: <20121012055301.GM11726@opensource.wolfsonmicro.com>
References: <1350009258-10044-1-git-send-email-voice.shen@atmel.com>
 <20121012044042.GI11726@opensource.wolfsonmicro.com>
 <5077A33E.4080801@atmel.com>
 <20121012051419.GJ11726@opensource.wolfsonmicro.com>
 <5077AE8C.5040605@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5077AE8C.5040605@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hskinnemoen@gmail.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 12, 2012 at 01:45:48PM +0800, Bo Shen wrote:
> On 10/12/2012 13:14, Mark Brown wrote:

> >No, this still makes no sense to me.  This is clearly a non-DT device
> >registration, what does DT have to do with anything here?  What is the

> Yes, this is non-DT device registration.
> As the Linux kernel code is transferring to DT which doesn't use
> platform device id. however here, modified unconsciously. So correct
> this error.

What error and what does DT have to do with any of this?  DT has no
impact on non-DT systems.

> >practical problem you are seeing in your system and how does this help
> >with it?

> In non-DT kernel, we use platform device id to distinguish between
> each device.

> So, in this case, if the id = -1, i2c core will dynamically assign a
> bus id to this bus when running, the dynamically assigned bus id is
> unknown when writing the code. So, when we use
> i2c_register_board_info(int busnum, ...) to register device on
> busnum. we don't know which value to be use.

The I2C bus number assigned to the controller should be independant of
the platform device ID used to register the device; a better fix if this
is an issue would be to update the i2c-gpio driver to allow a fixed bus
number to be specified in platform data.
