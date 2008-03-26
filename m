From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/1] Input/Joystick Driver: add support AD7142 joystick driver
Date: Wed, 26 Mar 2008 10:36:30 -0400
Message-ID: <8bd0f97a0803260736v58c11f8g8a5f740c62891174@mail.gmail.com>
References: <1206579622-21915-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1206579622-21915-1-git-send-email-cooloney@kernel.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: dmitry.torokhov@gmail.com, khali@linux-fr.org, linux-input@vger.kernel.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <bryan.wu@analog.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 26, 2008 at 9:00 PM, Bryan Wu <cooloney@kernel.org> wrote:
>  +config JOYSTICK_AD7142
>  +       tristate "Analog Devices AD7142 Joystick support"
>  +       depends on BLACKFIN && I2C
>  +       ---help---
>  +         Say Y here if you want to support an AD7142 joystick

since you're going to send another patch anyways ;), this kconfig text
could use a line telling you the module name if built as a module.
-mike
