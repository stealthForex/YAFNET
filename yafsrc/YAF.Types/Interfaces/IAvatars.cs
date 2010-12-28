﻿/* Yet Another Forum.NET
 * Copyright (C) 2006-2010 Jaben Cargman
 * http://www.yetanotherforum.net/
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */
namespace YAF.Types.Interfaces
{
  public interface IAvatars
  {
    /// <summary>
    /// The get avatar url for current user.
    /// </summary>
    /// <returns>
    /// The get avatar url for current user.
    /// </returns>
    string GetAvatarUrlForCurrentUser();

    /// <summary>
    /// The get avatar url for user.
    /// </summary>
    /// <param name="userId">
    /// The user id.
    /// </param>
    /// <returns>
    /// The get avatar url for user.
    /// </returns>
    string GetAvatarUrlForUser(int userId);

    /// <summary>
    /// The get avatar url for user.
    /// </summary>
    /// <param name="userData">
    /// The user data.
    /// </param>
    /// <returns>
    /// The get avatar url for user.
    /// </returns>
    string GetAvatarUrlForUser([NotNull] IUserData userData);
  }
}