From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: qestion about I2C_CLASS_HWMON flag
Date: Thu, 4 Sep 2008 10:49:55 +0200
Message-ID: <38b2ab8a0809040149u2bc0342h5c32b87f9277322f@mail.gmail.com>
References: <38b2ab8a0809040043g7f944872l47f84c53bb213829@mail.gmail.com>
	 <38b2ab8a0809040105j7ae3aca8xd334a4d203d9415b@mail.gmail.com>
	 <20080904103707.557ac764@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757207AbYIDIuL@vger.kernel.org>
In-Reply-To: <20080904103707.557ac764@hyperion.delvare>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 4, 2008 at 10:37 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Francis,
>
> On Thu, Sep 4, 2008 at 9:43 AM, Francis Moreau <francis.moro@gmail.com> wrote:
>> I'm wondering why does this flag exist ?
>>
>> Why is a hw monitor device so special so that an I2C bus needs
>> a flag to tell the rest of the world that it support it ?
>
> I don't understand your point. We have I2C_CLASS flags for many I2C
> device types (analog TV, digital TV, etc.) I2C_CLASS_HWMON isn't the
> exception you describe. Look at <linux/i2c.h> for a list of these flags.
>

My question (sorry if that silly) is why do we need these flags at all ?

Can't I2C bus address any kinds of I2C devices ?

What make hwmon devices special so that some I2C adapter can't
talk to them ?

Thanks
-- 
Francis
