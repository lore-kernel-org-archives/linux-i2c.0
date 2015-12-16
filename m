From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Dec 16 (i2c/busses/i2c-emev2)
Date: Wed, 16 Dec 2015 13:05:20 -0800
Message-ID: <5671D210.5050306@infradead.org>
References: <20151216164343.0cb641ce@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151216164343.0cb641ce@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@sang-engineering.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On 12/15/15 21:43, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20151215:
> 
> The drm-misc tree gained a conflict against Linus' tree.
> 
> The i2c tree gained a build failure for which I applied a patch.
> 
> The gpio tree gained a build failure so I used the version from
> next-20151215.
> 

on x86_64, when CONFIG_I2C_SLAVE is not enabled:



../drivers/i2c/busses/i2c-emev2.c: In function 'em_i2c_slave_irq':
../drivers/i2c/busses/i2c-emev2.c:233:23: error: storage size of 'event' isn't known
  enum i2c_slave_event event;
                       ^
../drivers/i2c/busses/i2c-emev2.c:250:3: error: implicit declaration of function 'i2c_slave_event' [-Werror=implicit-function-declaration]
   i2c_slave_event(priv->slave, I2C_SLAVE_STOP, &value);
   ^
../drivers/i2c/busses/i2c-emev2.c:250:32: error: 'I2C_SLAVE_STOP' undeclared (first use in this function)
   i2c_slave_event(priv->slave, I2C_SLAVE_STOP, &value);
                                ^
../drivers/i2c/busses/i2c-emev2.c:250:32: note: each undeclared identifier is reported only once for each function it appears in
../drivers/i2c/busses/i2c-emev2.c:270:5: error: 'I2C_SLAVE_READ_REQUESTED' undeclared (first use in this function)
     I2C_SLAVE_READ_REQUESTED :
     ^
../drivers/i2c/busses/i2c-emev2.c:271:5: error: 'I2C_SLAVE_READ_PROCESSED' undeclared (first use in this function)
     I2C_SLAVE_READ_PROCESSED;
     ^
../drivers/i2c/busses/i2c-emev2.c:286:33: error: 'I2C_SLAVE_WRITE_REQUESTED' undeclared (first use in this function)
    i2c_slave_event(priv->slave, I2C_SLAVE_WRITE_REQUESTED,
                                 ^
../drivers/i2c/busses/i2c-emev2.c:292:6: error: 'I2C_SLAVE_WRITE_RECEIVED' undeclared (first use in this function)
      I2C_SLAVE_WRITE_RECEIVED, &value);
      ^
../drivers/i2c/busses/i2c-emev2.c:233:23: warning: unused variable 'event' [-Wunused-variable]
  enum i2c_slave_event event;
                       ^
../drivers/i2c/busses/i2c-emev2.c: At top level:
../drivers/i2c/busses/i2c-emev2.c:353:2: error: unknown field 'reg_slave' specified in initializer
  .reg_slave      = em_i2c_reg_slave,
  ^
../drivers/i2c/busses/i2c-emev2.c:353:2: warning: excess elements in struct initializer [enabled by default]
../drivers/i2c/busses/i2c-emev2.c:353:2: warning: (near initialization for 'em_i2c_algo') [enabled by default]
../drivers/i2c/busses/i2c-emev2.c:354:2: error: unknown field 'unreg_slave' specified in initializer
  .unreg_slave    = em_i2c_unreg_slave,
  ^
../drivers/i2c/busses/i2c-emev2.c:354:2: warning: excess elements in struct initializer [enabled by default]
../drivers/i2c/busses/i2c-emev2.c:354:2: warning: (near initialization for 'em_i2c_algo') [enabled by default]
cc1: some warnings being treated as errors
../scripts/Makefile.build:264: recipe for target 'drivers/i2c/busses/i2c-emev2.o' failed

-- 
~Randy
