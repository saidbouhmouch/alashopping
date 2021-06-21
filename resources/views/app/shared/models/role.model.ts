
/**
 * Role model
 */
export interface IRole {
     id: number;
     name: string;
     guardName: string;
     createdAt: string;
     updatedAt: string;

}

export class Role {
     id: number;
     name: string;
     guardName: string;
     createdAt: string;
     updatedAt: string;

     constructor();
     constructor(role: IRole);
     constructor(role?: any) {
          this.id = role && role.id || 0;
          this.name = role && role.name || '';
          this.guardName = role && (role.guardName || role.guard_name) || '';
          this.createdAt = role && (role.createdAt || role.created_at) || '';
          this.updatedAt = role && (role.updatedAt || role.updated_at) || '';
     }

}
