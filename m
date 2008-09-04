From: Jean Delvare <khali@linux-fr.org>
Subject: Re: qestion about I2C_CLASS_HWMON flag
Date: Thu, 4 Sep 2008 10:37:07 +0200
Message-ID: <20080904103707.557ac764@hyperion.delvare>
References: <38b2ab8a0809040043g7f944872l47f84c53bb213829@mail.gmail.com>
	<38b2ab8a0809040105j7ae3aca8xd334a4d203d9415b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757285AbYIDIh3@vger.kernel.org>
In-Reply-To: <38b2ab8a0809040105j7ae3aca8xd334a4d203d9415b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Hi Francis,

On Thu, Sep 4, 2008 at 9:43 AM, Francis Moreau <francis.moro@gmail.com> wrote:
> I'm wondering why does this flag exist ?
>
> Why is a hw monitor device so special so that an I2C bus needs
> a flag to tell the rest of the world that it support it ?

I don't understand your point. We have I2C_CLASS flags for many I2C
device types (analog TV, digital TV, etc.) I2C_CLASS_HWMON isn't the
exception you describe. Look at <linux/i2c.h> for a list of these flags.

-- 
Jean Delvare
